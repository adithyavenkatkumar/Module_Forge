module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-ec2-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../../subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "pub-1" = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a" }
  }
}

module "ec2" {
  source        = "../../"
  name          = "ec2-example-01"
  ami_id        = "ami-0c55b159cbfafe1f0" # Mock / standard AMI
  instance_type = "t3.micro"
  subnet_id     = module.subnets.subnets["pub-1"].id
}
