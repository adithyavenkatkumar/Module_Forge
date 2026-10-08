variable "name" {
  type        = string
  description = "The name of the Network Security Group."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string)
    destination_port_ranges    = optional(list(string))
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
    description                = optional(string)
  }))
  description = "List of security rules."
  default     = []
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs to associate with this NSG."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
