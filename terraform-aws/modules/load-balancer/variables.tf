variable "name" {
  type        = string
  description = "Load Balancer name."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "internal" {
  type        = bool
  description = "Is internal load balancer."
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer (application, network)."
  default     = "application"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs."
  default     = []
}

variable "subnets" {
  type        = list(string)
  description = "List of Subnet IDs."
}

variable "target_groups" {
  type = map(object({
    port                  = number
    protocol              = string
    target_type           = optional(string, "instance")
    health_check_path     = optional(string, "/")
    health_check_protocol = optional(string, "HTTP")
  }))
  description = "Map of target groups."
}

variable "listeners" {
  type = map(object({
    port             = number
    protocol         = string
    target_group_key = string
  }))
  description = "Map of listeners."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
