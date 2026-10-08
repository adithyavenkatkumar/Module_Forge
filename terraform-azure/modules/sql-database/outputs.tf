output "server_id" {
  type        = string
  description = "SQL Server ID."
  value       = azurerm_mssql_server.sql.id
}

output "server_name" {
  type        = string
  description = "SQL Server Name."
  value       = azurerm_mssql_server.sql.name
}

output "fully_qualified_domain_name" {
  type        = string
  description = "FQDN of SQL Server."
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "database_ids" {
  type        = map(string)
  description = "Map of database IDs."
  value       = { for k, d in azurerm_mssql_database.db : k => d.id }
}
