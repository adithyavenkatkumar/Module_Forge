variable "name" {
  type        = string
  description = "Firewall name."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of Subnet IDs for firewall endpoints."
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
