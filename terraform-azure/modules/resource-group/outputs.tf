output "id" {
  type        = string
  description = "The ID of the Resource Group."
  value       = azurerm_resource_group.rg.id
}

output "name" {
  type        = string
  description = "The name of the Resource Group."
  value       = azurerm_resource_group.rg.name
}

output "location" {
  type        = string
  description = "The Azure Region where the Resource Group exists."
  value       = azurerm_resource_group.rg.location
}
