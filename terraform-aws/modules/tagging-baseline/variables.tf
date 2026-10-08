variable "workload" {
  type        = string
  description = "Workload or application name."
  default     = "core"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, test, staging, prod, dr)."
  default     = "dev"
}

variable "region" {
  type        = string
  description = "AWS Region."
  default     = "us-east-1"
}

variable "owner" {
  type        = string
  description = "Team or owner name."
  default     = "platform-team"
}

variable "cost_center" {
  type        = string
  description = "Cost Center code."
  default     = "cc-100"
}

variable "project" {
  type        = string
  description = "Project identifier."
  default     = "aws-enterprise-landing-zone"
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra key-value tags to include."
  default     = {}
}
