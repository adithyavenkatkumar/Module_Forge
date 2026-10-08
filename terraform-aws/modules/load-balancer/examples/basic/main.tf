module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-lb-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../../subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "pub-1" = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a" }
    "pub-2" = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b" }
  }
}

module "lb" {
  source  = "../../"
  name    = "alb-example"
  vpc_id  = module.vpc.vpc_id
  subnets = [module.subnets.subnets["pub-1"].id, module.subnets.subnets["pub-2"].id]
  target_groups = {
    "tg-web" = { port = 80, protocol = "HTTP" }
  }
  listeners = {
    "http" = { port = 80, protocol = "HTTP", target_group_key = "tg-web" }
  }
}
