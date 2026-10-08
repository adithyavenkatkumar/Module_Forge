output "id" {
  type        = string
  description = "The ID of Application Gateway."
  value       = azurerm_application_gateway.appgw.id
}

output "name" {
  type        = string
  description = "The name of Application Gateway."
  value       = azurerm_application_gateway.appgw.name
}
