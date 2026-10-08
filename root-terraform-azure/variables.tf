variable "workload" {
  type        = string
  description = "Workload or application name."
  default     = "enterprise"
}

variable "environment" {
  type        = string
  description = "Environment identifier (dev, test, staging, prod, dr)."
  default     = "prod"
}

variable "location" {
  type        = string
  description = "Azure Region for deployment."
  default     = "eastus"
}

variable "owner" {
  type        = string
  description = "Resource owner / team."
  default     = "platform-team"
}

variable "cost_center" {
  type        = string
  description = "Cost center identifier."
  default     = "cc-90001"
}

variable "project" {
  type        = string
  description = "Project name."
  default     = "azure-enterprise-landing-zone"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for Virtual Network."
  default     = "10.200.0.0/16"
}

variable "subnets" {
  type = map(object({
    address_prefixes                  = list(string)
    service_endpoints                 = optional(list(string), [])
    private_endpoint_network_policies = optional(string, "Enabled")
  }))
  description = "Map of subnets to create."
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string)
    destination_port_ranges    = optional(list(string))
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
    description                = optional(string)
  }))
  description = "Security rules for NSG."
  default     = []
}

variable "custom_routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  description = "Custom routes for Route Table."
  default     = []
}

variable "public_ips" {
  type = map(object({
    allocation_method = optional(string, "Static")
    sku               = optional(string, "Standard")
    domain_name_label = optional(string)
  }))
  description = "Map of Public IPs."
  default     = {}
}

variable "vms" {
  type = map(object({
    size             = string
    subnet_key       = string
    enable_public_ip = bool
  }))
  description = "Map of Virtual Machines to create."
  default     = {}
}

variable "admin_username" {
  type        = string
  description = "Admin username for VM."
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key content."
  default     = null
}

variable "kv_public_network_access" {
  type        = bool
  description = "Enable Key Vault public network access."
  default     = false
}

variable "storage_replication_type" {
  type        = string
  description = "Storage replication (LRS, GRS, ZRS)."
  default     = "GRS"
}

variable "storage_public_network_access" {
  type        = bool
  description = "Enable Storage public network access."
  default     = false
}

variable "storage_containers" {
  type = map(object({
    container_access_type = optional(string, "private")
  }))
  description = "Storage containers map."
  default     = {}
}

variable "managed_identities" {
  type = map(object({
    role_assignments = optional(list(object({
      role_definition_name = string
      scope                = string
    })), [])
  }))
  description = "User assigned identities map."
  default     = {}
}
