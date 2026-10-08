module "rg" {
  source   = "../../../resource-group"
  name     = "rg-lb-example"
  location = "eastus"
}

module "pip" {
  source              = "../../../public-ip"
  resource_group_name = module.rg.name
  location            = module.rg.location
  public_ips = {
    "pip-lb" = { allocation_method = "Static", sku = "Standard" }
  }
}

module "lb" {
  source              = "../../"
  name                = "lb-example-basic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  frontend_ip_configurations = {
    "PublicFrontend" = {
      public_ip_address_id = module.pip.public_ips["pip-lb"].id
    }
  }
}
