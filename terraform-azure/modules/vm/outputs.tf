output "id" {
  type        = string
  description = "The Virtual Machine ID."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "name" {
  type        = string
  description = "The Virtual Machine Name."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "private_ip_address" {
  type        = string
  description = "Primary Private IP address."
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "principal_id" {
  type        = string
  description = "System-assigned Identity Principal ID."
  value       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}
