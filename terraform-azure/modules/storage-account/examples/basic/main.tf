module "rg" {
  source   = "../../../resource-group"
  name     = "rg-sa-example"
  location = "eastus"
}

module "sa" {
  source                        = "../../"
  name                          = "stexbasic001"
  resource_group_name           = module.rg.name
  location                      = module.rg.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  containers = {
    "data" = { container_access_type = "private" }
  }
}
