variable "name" {
  type        = string
  description = "The name of the VPC."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC."
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in VPC."
  default     = true
}

variable "create_igw" {
  type        = bool
  description = "Create Internet Gateway."
  default     = true
}

variable "enable_flow_logs" {
  type        = bool
  description = "Enable VPC Flow Logs to CloudWatch."
  default     = true
}

variable "flow_log_retention_days" {
  type        = number
  description = "Flow log retention in days."
  default     = 30
}

variable "kms_key_arn" {
  type        = string
  description = "Optional KMS Key ARN for CloudWatch Log Group encryption."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
