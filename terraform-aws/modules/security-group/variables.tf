variable "name" {
  type        = string
  description = "Security Group name."
}

variable "description" {
  type        = string
  description = "Security Group description."
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "ingress_rules" {
  type = list(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string))
    security_groups  = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
  }))
  description = "Ingress rules list."
  default     = []
}

variable "egress_rules" {
  type = list(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), ["0.0.0.0/0"])
    security_groups  = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
  }))
  description = "Egress rules list."
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
