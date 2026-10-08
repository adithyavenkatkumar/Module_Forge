variable "name" {
  type        = string
  description = "The name of the Key Vault."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "sku_name" {
  type        = string
  description = "SKU Name (standard or premium)."
  default     = "standard"
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Enable RBAC authorization model."
  default     = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Enable purge protection."
  default     = true
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Retention days for soft delete."
  default     = 7
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access."
  default     = false
}

variable "network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  description = "Network ACLs."
  default     = null
}

variable "secrets" {
  type        = map(string)
  description = "Map of key-vault secret name and secret value."
  sensitive   = true
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
