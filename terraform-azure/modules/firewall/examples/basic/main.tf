module "rg" {
  source   = "../../../resource-group"
  name     = "rg-fw-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../../vnet"
  name                = "vnet-fw-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "subnets" {
  source               = "../../../subnet"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  subnets = {
    "AzureFirewallSubnet" = {
      address_prefixes = ["10.0.1.0/26"]
    }
  }
}

module "fw" {
  source              = "../../"
  name                = "afw-example-basic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnets.subnets["AzureFirewallSubnet"].id
}
