variable "vpc_id" {
  type        = string
  description = "The VPC ID."
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, false)
    type                    = optional(string, "private")
  }))
  description = "Map of subnets."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
