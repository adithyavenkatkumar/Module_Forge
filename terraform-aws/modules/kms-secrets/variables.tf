variable "kms_key_description" {
  type        = string
  description = "Description for KMS Key."
  default     = "CMK for data encryption"
}

variable "kms_alias_name" {
  type        = string
  description = "Alias name for KMS Key."
}

variable "secrets" {
  type = map(object({
    description             = optional(string)
    secret_string           = optional(string)
    recovery_window_in_days = optional(number, 30)
  }))
  description = "Map of Secrets Manager secrets."
  default     = {}
}

variable "ssm_parameters" {
  type = map(object({
    type  = optional(string, "SecureString")
    value = string
  }))
  description = "Map of SSM parameters."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
