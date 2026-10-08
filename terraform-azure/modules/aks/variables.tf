variable "name" {
  type        = string
  description = "The name of the AKS cluster."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster."
}

variable "kubernetes_version" {
  type        = string
  description = "Version of Kubernetes."
  default     = null
}

variable "default_node_pool" {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    vnet_subnet_id      = optional(string)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number)
    max_count           = optional(number)
    os_disk_size_gb     = optional(number, 128)
  })
  description = "Default Node Pool configuration."
}

variable "extra_node_pools" {
  type = map(object({
    vm_size             = string
    node_count          = optional(number, 1)
    vnet_subnet_id      = optional(string)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number)
    max_count           = optional(number)
  }))
  description = "Map of extra node pools."
  default     = {}
}

variable "identity_type" {
  type        = string
  description = "Managed Identity Type."
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "List of User Assigned Identity IDs."
  default     = null
}

variable "network_profile" {
  type = object({
    network_plugin    = string
    network_policy    = optional(string)
    load_balancer_sku = optional(string, "standard")
  })
  description = "Network profile."
  default = {
    network_plugin = "azure"
    network_policy = "azure"
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
