variable "enis" {
  type = map(object({
    subnet_id       = string
    private_ips     = optional(list(string))
    security_groups = optional(list(string))
  }))
  description = "Map of Elastic Network Interfaces to create."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
