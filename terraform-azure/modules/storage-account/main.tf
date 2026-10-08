resource "azurerm_storage_account" "sa" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  min_tls_version                 = var.min_tls_version
  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  tags                            = merge(var.tags, { ManagedBy = "terraform" })

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      ip_rules                   = lookup(network_rules.value, "ip_rules", [])
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", [])
      bypass                     = lookup(network_rules.value, "bypass", ["AzureServices"])
    }
  }
}

resource "azurerm_storage_container" "containers" {
  for_each              = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = lookup(each.value, "container_access_type", "private")
}

resource "azurerm_storage_share" "shares" {
  for_each             = var.file_shares
  name                 = each.key
  storage_account_name = azurerm_storage_account.sa.name
  quota                = lookup(each.value, "quota", 50)
}
