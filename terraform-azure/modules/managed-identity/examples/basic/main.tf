module "rg" {
  source   = "../../../resource-group"
  name     = "rg-mi-example"
  location = "eastus"
}

module "mi" {
  source              = "../../"
  resource_group_name = module.rg.name
  location            = module.rg.location
  identities = {
    "id-app-worker" = {}
  }
}
