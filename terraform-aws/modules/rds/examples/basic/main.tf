module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-rds-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../../subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "db-1" = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a" }
    "db-2" = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b" }
  }
}

module "rds" {
  source                      = "../../"
  identifier                  = "rds-example-db"
  subnet_ids                  = [module.subnets.subnets["db-1"].id, module.subnets.subnets["db-2"].id]
  manage_master_user_password = true
}
