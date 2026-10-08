variable "cluster_name" {
  type        = string
  description = "EKS Cluster Name."
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version."
  default     = "1.29"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for cluster and node pools."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Enable public access to API endpoint."
  default     = false
}

variable "node_groups" {
  type = map(object({
    instance_types = optional(list(string), ["t3.medium"])
    desired_size   = optional(number, 2)
    min_size       = optional(number, 1)
    max_size       = optional(number, 4)
  }))
  description = "Map of EKS node groups."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
