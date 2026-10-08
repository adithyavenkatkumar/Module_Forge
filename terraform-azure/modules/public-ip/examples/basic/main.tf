module "rg" {
  source   = "../../../resource-group"
  name     = "rg-pip-example"
  location = "eastus"
}

module "pip" {
  source              = "../../"
  resource_group_name = module.rg.name
  location            = module.rg.location
  public_ips = {
    "pip-app-dev" = {
      allocation_method = "Static"
      sku               = "Standard"
    }
  }
}
