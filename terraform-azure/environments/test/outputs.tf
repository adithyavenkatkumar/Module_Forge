output "resource_group_name" {
  description = "Resource group name."
  value       = module.resource_group.name
}

output "vnet_id" {
  description = "Virtual Network ID."
  value       = module.vnet.id
}

output "subnet_ids" {
  description = "Map of Subnet IDs."
  value       = { for k, s in module.subnet.subnets : k => s.id }
}

output "key_vault_uri" {
  description = "Key Vault URI."
  value       = module.key_vault.vault_uri
}

output "storage_blob_endpoint" {
  description = "Storage account blob endpoint."
  value       = module.storage_account.primary_blob_endpoint
}

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID."
  value       = module.monitoring.workspace_id
}

output "vm_private_ips" {
  description = "Map of VM private IPs."
  value       = { for k, v in module.vm : k => v.private_ip_address }
}
