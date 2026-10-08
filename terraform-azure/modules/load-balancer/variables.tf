variable "name" {
  type        = string
  description = "The name of the Load Balancer."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "sku" {
  type        = string
  description = "SKU of Load Balancer."
  default     = "Standard"
}

variable "frontend_ip_configurations" {
  type = map(object({
    public_ip_address_id          = optional(string)
    subnet_id                     = optional(string)
    private_ip_address            = optional(string)
    private_ip_address_allocation = optional(string, "Dynamic")
  }))
  description = "Map of Frontend IP Configurations."
}

variable "backend_pools" {
  type        = map(object({}))
  description = "Map of Backend pools."
  default     = {}
}

variable "probes" {
  type = map(object({
    port         = number
    protocol     = optional(string, "Tcp")
    request_path = optional(string)
  }))
  description = "Map of Probes."
  default     = {}
}

variable "rules" {
  type = map(object({
    frontend_ip_configuration_name = string
    protocol                       = optional(string, "Tcp")
    frontend_port                  = number
    backend_port                   = number
    backend_pool_name              = string
    probe_name                     = optional(string)
  }))
  description = "Map of LB rules."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
