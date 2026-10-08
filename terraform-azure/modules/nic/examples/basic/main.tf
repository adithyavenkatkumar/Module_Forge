module "rg" {
  source   = "../../../resource-group"
  name     = "rg-nic-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../../vnet"
  name                = "vnet-nic-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "subnets" {
  source               = "../../../subnet"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  subnets = {
    "nic-subnet" = { address_prefixes = ["10.0.1.0/24"] }
  }
}

module "nic" {
  source              = "../../"
  resource_group_name = module.rg.name
  location            = module.rg.location
  nics = {
    "nic-vm-01" = {
      subnet_id = module.subnets.subnets["nic-subnet"].id
    }
  }
}
