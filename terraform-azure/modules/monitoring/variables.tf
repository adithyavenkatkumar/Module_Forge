variable "workspace_name" {
  type        = string
  description = "Log Analytics Workspace Name."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "sku" {
  type        = string
  description = "Log Analytics SKU."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "Workspace data retention in days."
  default     = 30
}

variable "app_insights_name" {
  type        = string
  description = "Optional Application Insights Name."
  default     = null
}

variable "application_type" {
  type        = string
  description = "Application type for App Insights."
  default     = "web"
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
