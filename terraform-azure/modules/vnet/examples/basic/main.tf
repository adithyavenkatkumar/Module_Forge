module "rg" {
  source   = "../../../resource-group"
  name     = "rg-vnet-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../"
  name                = "vnet-example-basic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.1.0.0/16"]
}
