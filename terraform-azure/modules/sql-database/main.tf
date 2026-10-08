resource "azurerm_mssql_server" "sql" {
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = merge(var.tags, { ManagedBy = "terraform" })

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []
    content {
      login_username              = azuread_administrator.value.login_username
      object_id                   = azuread_administrator.value.object_id
      azuread_authentication_only = lookup(azuread_administrator.value, "azuread_authentication_only", true)
    }
  }
}

resource "azurerm_mssql_database" "db" {
  for_each    = var.databases
  name        = each.key
  server_id   = azurerm_mssql_server.sql.id
  sku_name    = lookup(each.value, "sku_name", "S0")
  max_size_gb = lookup(each.value, "max_size_gb", 10)
  tags        = merge(var.tags, { ManagedBy = "terraform" })
}
