module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-nfw-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../../subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "fw-sub" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
  }
}

module "nfw" {
  source     = "../../"
  name       = "nfw-example"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.subnets.subnets["fw-sub"].id]
}
