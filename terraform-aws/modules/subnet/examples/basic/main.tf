module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-subnet-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "public-1" = {
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      type                    = "public"
    }
  }
}
