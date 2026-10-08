output "id" {
  type        = string
  description = "The ID of the VPN Gateway."
  value       = azurerm_virtual_network_gateway.vpn.id
}

output "public_ip_address" {
  type        = string
  description = "The Public IP address of the Gateway."
  value       = azurerm_public_ip.pip.ip_address
}
