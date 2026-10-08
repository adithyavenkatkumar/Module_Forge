resource "azurerm_log_analytics_workspace" "law" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}

resource "azurerm_application_insights" "appinsights" {
  count               = var.app_insights_name != null ? 1 : 0
  name                = var.app_insights_name
  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_id        = azurerm_log_analytics_workspace.law.id
  application_type    = var.application_type
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}
