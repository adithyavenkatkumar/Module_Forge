variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "identities" {
  type = map(object({
    role_assignments = optional(list(object({
      role_definition_name = string
      scope                = string
    })), [])
  }))
  description = "Map of user assigned identities and their role assignments."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
