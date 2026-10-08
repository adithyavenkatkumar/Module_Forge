module "rg" {
  source   = "../../../resource-group"
  name     = "rg-vpn-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../../vnet"
  name                = "vnet-vpn-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "subnets" {
  source               = "../../../subnet"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  subnets = {
    "GatewaySubnet" = {
      address_prefixes = ["10.0.255.0/27"]
    }
  }
}

module "vpn" {
  source              = "../../"
  name                = "vpngw-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnets.subnets["GatewaySubnet"].id
}
