variable "name" {
  type        = string
  description = "The name of the Route Table."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable BGP route propagation."
  default     = true
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  description = "List of route objects."
  default     = []
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs to associate with this route table."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
