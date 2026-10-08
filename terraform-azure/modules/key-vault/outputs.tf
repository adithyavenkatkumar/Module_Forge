output "id" {
  type        = string
  description = "Key Vault ID."
  value       = azurerm_key_vault.kv.id
}

output "name" {
  type        = string
  description = "Key Vault Name."
  value       = azurerm_key_vault.kv.name
}

output "vault_uri" {
  type        = string
  description = "Key Vault URI."
  value       = azurerm_key_vault.kv.vault_uri
}

output "secrets" {
  type        = map(string)
  description = "Map of created secret IDs."
  value       = { for k, s in azurerm_key_vault_secret.secrets : k => s.id }
}
