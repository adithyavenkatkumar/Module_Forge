output "id" {
  type        = string
  description = "The ID of the Network Security Group."
  value       = azurerm_network_security_group.nsg.id
}

output "name" {
  type        = string
  description = "The name of the Network Security Group."
  value       = azurerm_network_security_group.nsg.name
}

output "associated_subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs associated."
  value       = var.subnet_ids
}
