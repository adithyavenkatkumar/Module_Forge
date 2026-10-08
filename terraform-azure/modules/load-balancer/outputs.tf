output "id" {
  type        = string
  description = "The ID of the Load Balancer."
  value       = azurerm_lb.lb.id
}

output "backend_pool_ids" {
  type        = map(string)
  description = "Map of backend pool IDs."
  value       = { for k, p in azurerm_lb_backend_address_pool.pool : k => p.id }
}
