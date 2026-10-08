output "id" {
  type        = string
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  type        = string
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}

output "address_space" {
  type        = list(string)
  description = "The address space of the Virtual Network."
  value       = azurerm_virtual_network.vnet.address_space
}
