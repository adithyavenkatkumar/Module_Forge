module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-vpn-example"
  cidr_block = "10.0.0.0/16"
}

module "vpn" {
  source     = "../../"
  name       = "vpn-example"
  vpc_id     = module.vpc.vpc_id
  ip_address = "203.0.113.12"
}
