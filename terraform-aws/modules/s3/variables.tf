variable "bucket_name" {
  type        = string
  description = "Name of the S3 Bucket."
}

variable "force_destroy" {
  type        = bool
  description = "Force destroy bucket contents."
  default     = false
}

variable "versioning_status" {
  type        = string
  description = "Versioning status (Enabled, Suspended, Disabled)."
  default     = "Enabled"
}

variable "kms_master_key_id" {
  type        = string
  description = "Optional KMS Master Key ID/ARN."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
