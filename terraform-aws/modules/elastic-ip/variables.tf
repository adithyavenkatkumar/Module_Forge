variable "eips" {
  type = map(object({
    domain               = optional(string, "vpc")
    instance_id          = optional(string)
    network_interface_id = optional(string)
  }))
  description = "Map of Elastic IPs to allocate."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
