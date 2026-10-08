# Root AWS deployment composition instantiating reusable modules from terraform-aws/modules

module "baseline" {
  source      = "../terraform-aws/modules/tagging-baseline"
  workload    = var.workload
  environment = var.environment
  region      = var.region
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}

module "vpc" {
  source     = "../terraform-aws/modules/vpc"
  name       = local.vpc_name
  cidr_block = var.vpc_cidr
  tags       = local.common_tags
}

module "subnet" {
  source  = "../terraform-aws/modules/subnet"
  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets
  tags    = local.common_tags
}

module "route_table" {
  source     = "../terraform-aws/modules/route-table"
  name       = local.rt_name
  vpc_id     = module.vpc.vpc_id
  subnet_ids = { for k, s in module.subnet.subnets : k => s.id }
  tags       = local.common_tags
}

module "security_group" {
  source        = "../terraform-aws/modules/security-group"
  name          = local.sg_name
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.ingress_rules
  tags          = local.common_tags
}

module "kms_secrets" {
  source         = "../terraform-aws/modules/kms-secrets"
  kms_alias_name = local.kms_alias
  secrets = {
    "app/db-master-pass" = { description = "Master DB Password" }
  }
  tags = local.common_tags
}

module "s3" {
  source            = "../terraform-aws/modules/s3"
  bucket_name       = local.s3_name
  kms_master_key_id = module.kms_secrets.kms_key_arn
  tags              = local.common_tags
}

module "iam" {
  source = "../terraform-aws/modules/iam"
  roles = {
    "ec2-app-role" = {
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Action    = "sts:AssumeRole"
          Effect    = "Allow"
          Principal = { Service = "ec2.amazonaws.com" }
        }]
      })
      policy_arns             = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
      create_instance_profile = true
    }
  }
  tags = local.common_tags
}

module "ec2" {
  for_each               = var.instances
  source                 = "../terraform-aws/modules/ec2"
  name                   = "${local.naming_prefix}-${each.key}"
  ami_id                 = var.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = module.subnet.subnets[each.value.subnet_key].id
  vpc_security_group_ids = [module.security_group.security_group_id]
  iam_instance_profile   = module.iam.instance_profiles["ec2-app-role"]
  tags                   = local.common_tags
}

module "monitoring" {
  source         = "../terraform-aws/modules/monitoring"
  log_group_name = "/aws/app/${local.naming_prefix}"
  kms_key_arn    = module.kms_secrets.kms_key_arn
  tags           = local.common_tags
}
