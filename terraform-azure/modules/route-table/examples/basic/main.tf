module "rg" {
  source   = "../../../resource-group"
  name     = "rg-rt-example"
  location = "eastus"
}

module "rt" {
  source              = "../../"
  name                = "rt-example-basic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  routes = [
    {
      name           = "InternetDefault"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}
