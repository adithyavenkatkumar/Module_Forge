module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-sg-example"
  cidr_block = "10.0.0.0/16"
}

module "sg" {
  source = "../../"
  name   = "sg-web-example"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
