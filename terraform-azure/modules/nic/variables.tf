variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "nics" {
  type = map(object({
    subnet_id                     = string
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address            = optional(string)
    public_ip_id                  = optional(string)
    nsg_id                        = optional(string)
  }))
  description = "Map of Network Interfaces to create."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
