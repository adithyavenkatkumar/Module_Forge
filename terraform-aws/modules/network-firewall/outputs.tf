output "firewall_id" {
  type        = string
  description = "Network Firewall ID."
  value       = aws_networkfirewall_firewall.nfw.id
}

output "firewall_arn" {
  type        = string
  description = "Network Firewall ARN."
  value       = aws_networkfirewall_firewall.nfw.arn
}
