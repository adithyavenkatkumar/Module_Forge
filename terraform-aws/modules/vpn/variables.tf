variable "name" {
  type        = string
  description = "VPN prefix name."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "bgp_asn" {
  type        = number
  description = "Customer gateway BGP ASN."
  default     = 65000
}

variable "ip_address" {
  type        = string
  description = "Customer Gateway Public IP address."
}

variable "static_routes_only" {
  type        = bool
  description = "Static routes only."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
