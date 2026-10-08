module "vpc" {
  source     = "../../../vpc"
  name       = "vpc-eks-example"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "../../../subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "priv-1" = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a" }
    "priv-2" = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b" }
  }
}

module "eks" {
  source       = "../../"
  cluster_name = "eks-example-cluster"
  subnet_ids   = [module.subnets.subnets["priv-1"].id, module.subnets.subnets["priv-2"].id]
  node_groups = {
    "system" = { desired_size = 2, min_size = 1, max_size = 3 }
  }
}
