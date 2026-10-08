variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "public_ips" {
  type = map(object({
    allocation_method = optional(string, "Static")
    sku               = optional(string, "Standard")
    domain_name_label = optional(string)
  }))
  description = "Map of public IPs to create."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
