variable "server_name" {
  type        = string
  description = "The name of the Azure SQL Server."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "server_version" {
  type        = string
  description = "SQL Server version."
  default     = "12.0"
}

variable "administrator_login" {
  type        = string
  description = "SQL Server administrator username."
  default     = "sqladmin"
}

variable "administrator_login_password" {
  type        = string
  description = "SQL Server administrator password."
  sensitive   = true
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access."
  default     = false
}

variable "azuread_administrator" {
  type = object({
    login_username              = string
    object_id                   = string
    azuread_authentication_only = optional(bool, true)
  })
  description = "Entra AD Admin config."
  default     = null
}

variable "databases" {
  type = map(object({
    sku_name    = optional(string, "S0")
    max_size_gb = optional(number, 10)
  }))
  description = "Map of databases to create."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
