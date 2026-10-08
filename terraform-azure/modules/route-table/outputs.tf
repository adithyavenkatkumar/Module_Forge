output "id" {
  type        = string
  description = "The ID of the Route Table."
  value       = azurerm_route_table.rt.id
}

output "name" {
  type        = string
  description = "The name of the Route Table."
  value       = azurerm_route_table.rt.name
}
