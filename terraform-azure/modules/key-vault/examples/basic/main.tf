module "rg" {
  source   = "../../../resource-group"
  name     = "rg-kv-example"
  location = "eastus"
}

module "kv" {
  source                        = "../../"
  name                          = "kv-example-basic-001"
  resource_group_name           = module.rg.name
  location                      = module.rg.location
  public_network_access_enabled = true
}
