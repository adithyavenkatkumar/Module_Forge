output "id" {
  type        = string
  description = "The ID of the Firewall."
  value       = azurerm_firewall.fw.id
}

output "name" {
  type        = string
  description = "The name of the Firewall."
  value       = azurerm_firewall.fw.name
}

output "private_ip" {
  type        = string
  description = "Private IP of the Azure Firewall."
  value       = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}
