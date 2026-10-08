module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-rt-example"
  cidr_block = "10.0.0.0/16"
}

module "rt" {
  source = "../../"
  name   = "rt-example"
  vpc_id = module.vpc.vpc_id
}
