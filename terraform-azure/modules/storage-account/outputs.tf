output "id" {
  type        = string
  description = "Storage Account ID."
  value       = azurerm_storage_account.sa.id
}

output "name" {
  type        = string
  description = "Storage Account Name."
  value       = azurerm_storage_account.sa.name
}

output "primary_blob_endpoint" {
  type        = string
  description = "Primary Blob Endpoint."
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}

output "primary_access_key" {
  type        = string
  description = "Primary Access Key."
  sensitive   = true
  value       = azurerm_storage_account.sa.primary_access_key
}
