variable "name" {
  type        = string
  description = "The name of the Virtual Network."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the Virtual Network."
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
