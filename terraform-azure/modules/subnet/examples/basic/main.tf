module "rg" {
  source   = "../../../resource-group"
  name     = "rg-subnet-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../../vnet"
  name                = "vnet-subnet-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "subnets" {
  source               = "../../"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  subnets = {
    "frontend" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}
