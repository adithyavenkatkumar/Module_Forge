module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-eni-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../../subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "sub-1" = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a" }
  }
}

module "eni" {
  source = "../../"
  enis = {
    "eni-app-01" = { subnet_id = module.subnets.subnets["sub-1"].id }
  }
}
