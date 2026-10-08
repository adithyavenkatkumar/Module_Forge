variable "name" {
  type        = string
  description = "The name of the Resource Group."

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 90
    error_message = "Resource Group name must be between 1 and 90 characters."
  }
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist."
  default     = "eastus"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
