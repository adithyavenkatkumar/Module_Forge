variable "name" {
  type        = string
  description = "The name of the Azure Firewall."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "sku_name" {
  type        = string
  description = "SKU Name of Azure Firewall. Options: AZFW_VNet, AZFW_Hub."
  default     = "AZFW_VNet"
}

variable "sku_tier" {
  type        = string
  description = "SKU Tier of Azure Firewall. Options: Standard, Premium, Basic."
  default     = "Standard"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the AzureFirewallSubnet."
}

variable "public_ip_id" {
  type        = string
  description = "Optional pre-created Public IP ID."
  default     = null
}

variable "firewall_policy_id" {
  type        = string
  description = "Optional pre-created Firewall Policy ID."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
