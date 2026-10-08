variable "name" {
  type        = string
  description = "Route Table name."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "routes" {
  type = list(object({
    cidr_block                = optional(string)
    ipv6_cidr_block           = optional(string)
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    network_interface_id      = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  description = "List of route entries."
  default     = []
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs to associate."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
