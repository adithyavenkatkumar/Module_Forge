module "vpc" {
  source     = "../../"
  name       = "vpc-example-basic"
  cidr_block = "10.0.0.0/16"
}
