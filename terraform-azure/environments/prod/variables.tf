variable "workload" {
  type        = string
  description = "Name of the workload or application."
  default     = "core"
}

variable "environment" {
  type        = string
  description = "Environment identifier (dev, test, staging, prod, dr)."
  default     = "prod"
}

variable "location" {
  type        = string
  description = "Azure region for deployment."
  default     = "eastus"
}

variable "owner" {
  type        = string
  description = "Team or individual owner."
  default     = "platform-team"
}

variable "cost_center" {
  type        = string
  description = "Cost Center for financial allocation."
  default     = "cc-10293"
}

variable "project" {
  type        = string
  description = "Project identifier."
  default     = "azure-enterprise-landing-zone"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for the Virtual Network."
}

variable "subnets" {
  type = map(object({
    address_prefixes                  = list(string)
    service_endpoints                 = optional(list(string), [])
    private_endpoint_network_policies = optional(string, "Enabled")
  }))
  description = "Subnet definitions."
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
  description = "Custom route entries."
  default     = []
}

variable "public_ips" {
  type = map(object({
    allocation_method = optional(string, "Static")
    sku               = optional(string, "Standard")
    domain_name_label = optional(string)
  }))
  description = "Map of public IPs."
  default     = {}
}

variable "vms" {
  type = map(object({
    size             = string
    subnet_key       = string
    enable_public_ip = bool
  }))
  description = "Map of VMs to deploy."
  default     = {}
}

variable "admin_username" {
  type        = string
  description = "Admin username for virtual machines."
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key content for VM authentication."
  default     = null
}

variable "kv_public_network_access" {
  type        = bool
  description = "Enable public access to Key Vault."
  default     = false
}

variable "storage_replication_type" {
  type        = string
  description = "Storage replication (LRS, GRS, ZRS)."
  default     = "LRS"
}

variable "storage_public_network_access" {
  type        = bool
  description = "Enable public network access to Storage."
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
  description = "Managed identities map."
  default     = {}
}
