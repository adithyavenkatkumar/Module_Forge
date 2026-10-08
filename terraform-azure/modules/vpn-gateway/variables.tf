variable "name" {
  type        = string
  description = "The name of the VPN Gateway."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "type" {
  type        = string
  description = "The type of Virtual Network Gateway (Vpn or ExpressRoute)."
  default     = "Vpn"
}

variable "vpn_type" {
  type        = string
  description = "The routing type of Virtual Network Gateway."
  default     = "RouteBased"
}

variable "sku" {
  type        = string
  description = "Configuration SKU for Virtual Network Gateway."
  default     = "VpnGw1"
}

variable "subnet_id" {
  type        = string
  description = "The GatewaySubnet ID."
}

variable "local_network_gateways" {
  type = map(object({
    gateway_address = string
    address_space   = list(string)
  }))
  description = "Map of site-to-site local network gateways."
  default     = {}
}

variable "shared_key" {
  type        = string
  description = "Shared key for IPsec VPN connection."
  sensitive   = true
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
