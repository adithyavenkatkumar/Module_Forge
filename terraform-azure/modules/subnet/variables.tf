variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the Virtual Network."
}

variable "subnets" {
  type = map(object({
    address_prefixes                  = list(string)
    service_endpoints                 = optional(list(string), [])
    private_endpoint_network_policies = optional(string, "Enabled")
    delegations = optional(list(object({
      name         = string
      service_name = string
      actions      = optional(list(string), [])
    })), [])
  }))
  description = "Map of subnets to create."
}
