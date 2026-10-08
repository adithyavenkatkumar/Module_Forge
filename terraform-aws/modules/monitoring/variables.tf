variable "log_group_name" {
  type        = string
  description = "CloudWatch Log Group Name."
}

variable "retention_in_days" {
  type        = number
  description = "Log retention in days."
  default     = 30
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for log encryption."
  default     = null
}

variable "alarm_topic_name" {
  type        = string
  description = "Optional SNS Alert Topic Name."
  default     = null
}

variable "enable_cloudtrail" {
  type        = bool
  description = "Enable CloudTrail trail."
  default     = false
}

variable "trail_name" {
  type        = string
  description = "CloudTrail name."
  default     = "main-cloudtrail"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket Name for CloudTrail storage."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
