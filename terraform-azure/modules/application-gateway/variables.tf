variable "name" {
  type        = string
  description = "The name of the Application Gateway."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where Application Gateway resides."
}

variable "sku" {
  type = object({
    name     = string
    tier     = string
    capacity = number
  })
  description = "SKU block."
  default = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
}

variable "frontend_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = "List of Frontend Ports."
}

variable "frontend_ip_configurations" {
  type = list(object({
    name                 = string
    public_ip_address_id = optional(string)
    subnet_id            = optional(string)
  }))
  description = "List of Frontend IP Configurations."
}

variable "backend_pools" {
  type = list(object({
    name         = string
    ip_addresses = optional(list(string))
    fqdns        = optional(list(string))
  }))
  description = "List of Backend pools."
}

variable "backend_http_settings" {
  type = list(object({
    name                  = string
    port                  = number
    protocol              = string
    cookie_based_affinity = optional(string, "Disabled")
    request_timeout       = optional(number, 20)
  }))
  description = "List of Backend HTTP settings."
}

variable "http_listeners" {
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
  }))
  description = "List of HTTP Listeners."
}

variable "request_routing_rules" {
  type = list(object({
    name                       = string
    rule_type                  = optional(string, "Basic")
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = optional(number, 100)
  }))
  description = "List of Request Routing Rules."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
