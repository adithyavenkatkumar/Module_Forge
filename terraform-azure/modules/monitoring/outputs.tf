output "workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID."
  value       = azurerm_log_analytics_workspace.law.id
}

output "workspace_name" {
  type        = string
  description = "Log Analytics Workspace Name."
  value       = azurerm_log_analytics_workspace.law.name
}

output "app_insights_id" {
  type        = string
  description = "Application Insights ID."
  value       = length(azurerm_application_insights.appinsights) > 0 ? azurerm_application_insights.appinsights[0].id : null
}

output "app_insights_instrumentation_key" {
  type        = string
  description = "Application Insights Instrumentation Key."
  sensitive   = true
  value       = length(azurerm_application_insights.appinsights) > 0 ? azurerm_application_insights.appinsights[0].instrumentation_key : null
}

output "app_insights_connection_string" {
  type        = string
  description = "Application Insights Connection String."
  sensitive   = true
  value       = length(azurerm_application_insights.appinsights) > 0 ? azurerm_application_insights.appinsights[0].connection_string : null
}
