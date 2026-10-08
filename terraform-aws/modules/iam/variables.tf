variable "roles" {
  type = map(object({
    assume_role_policy      = string
    policy_arns             = optional(list(string), [])
    create_instance_profile = optional(bool, false)
  }))
  description = "Map of IAM roles."
  default     = {}
}

variable "custom_policies" {
  type = map(object({
    description = optional(string)
    policy      = string
  }))
  description = "Map of custom IAM policies."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
