# Root composition module for prod environment.
# Modules referenced locally can also be referenced via versioned Git repository, e.g.:
# source = "git::https://github.com/my-org/terraform-aws.git//modules/vpc?ref=v1.0.0"

module "baseline" {
  source      = "../../modules/tagging-baseline"
  workload    = var.workload
  environment = var.environment
  region      = var.region
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = local.vpc_name
  cidr_block = var.vpc_cidr
  tags       = local.common_tags
}

module "subnet" {
  source  = "../../modules/subnet"
  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets
  tags    = local.common_tags
}

module "route_table" {
  source     = "../../modules/route-table"
  name       = local.rt_name
  vpc_id     = module.vpc.vpc_id
  subnet_ids = { for k, s in module.subnet.subnets : k => s.id }
  tags       = local.common_tags
}

module "security_group" {
  source        = "../../modules/security-group"
  name          = local.sg_name
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.ingress_rules
  tags          = local.common_tags
}

module "kms_secrets" {
  source         = "../../modules/kms-secrets"
  kms_alias_name = local.kms_alias
  secrets = {
    "app/db-master-pass" = { description = "Master DB Password" }
  }
  tags = local.common_tags
}

module "s3" {
  source            = "../../modules/s3"
  bucket_name       = local.s3_name
  kms_master_key_id = module.kms_secrets.kms_key_arn
  tags              = local.common_tags
}

module "iam" {
  source = "../../modules/iam"
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
  source                 = "../../modules/ec2"
  name                   = "${local.naming_prefix}-${each.key}"
  ami_id                 = var.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = module.subnet.subnets[each.value.subnet_key].id
  vpc_security_group_ids = [module.security_group.security_group_id]
  iam_instance_profile   = module.iam.instance_profiles["ec2-app-role"]
  tags                   = local.common_tags
}

module "monitoring" {
  source         = "../../modules/monitoring"
  log_group_name = "/aws/app/${local.naming_prefix}"
  kms_key_arn    = module.kms_secrets.kms_key_arn
  tags           = local.common_tags
}
