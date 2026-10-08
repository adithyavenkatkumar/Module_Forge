output "vpn_gateway_id" {
  type        = string
  description = "VPN Gateway ID."
  value       = aws_vpn_gateway.vgw.id
}

output "customer_gateway_id" {
  type        = string
  description = "Customer Gateway ID."
  value       = aws_customer_gateway.cgw.id
}

output "vpn_connection_id" {
  type        = string
  description = "VPN Connection ID."
  value       = aws_vpn_connection.vpn.id
}
