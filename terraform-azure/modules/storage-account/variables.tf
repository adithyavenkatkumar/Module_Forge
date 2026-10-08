variable "name" {
  type        = string
  description = "The name of the Storage Account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "account_tier" {
  type        = string
  description = "Defines Tier (Standard or Premium)."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Replication type (LRS, GRS, RAGRS, ZRS)."
  default     = "LRS"
}

variable "min_tls_version" {
  type        = string
  description = "Minimum TLS version."
  default     = "TLS1_2"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access."
  default     = false
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow public blob access."
  default     = false
}

variable "containers" {
  type = map(object({
    container_access_type = optional(string, "private")
  }))
  description = "Map of containers to create."
  default     = {}
}

variable "file_shares" {
  type = map(object({
    quota = optional(number, 50)
  }))
  description = "Map of file shares to create."
  default     = {}
}

variable "network_rules" {
  type = object({
    default_action             = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
    bypass                     = optional(list(string), ["AzureServices"])
  })
  description = "Network rules for storage account."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
