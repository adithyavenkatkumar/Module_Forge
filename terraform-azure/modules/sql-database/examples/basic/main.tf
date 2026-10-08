module "rg" {
  source   = "../../../resource-group"
  name     = "rg-sql-example"
  location = "eastus"
}

module "sql" {
  source                        = "../../"
  server_name                   = "sql-server-ex-001"
  resource_group_name           = module.rg.name
  location                      = module.rg.location
  administrator_login           = "sqladmin"
  administrator_login_password  = "P@ssw0rd12345678!"
  public_network_access_enabled = true
  databases = {
    "appdb" = { sku_name = "S0", max_size_gb = 5 }
  }
}
