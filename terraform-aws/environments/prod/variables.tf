variable "workload" {
  type        = string
  description = "Workload name."
  default     = "core"
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "prod"
}

variable "region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "owner" {
  type        = string
  description = "Team owner."
  default     = "devops-team"
}

variable "cost_center" {
  type        = string
  description = "Cost Center."
  default     = "cc-99120"
}

variable "project" {
  type        = string
  description = "Project name."
  default     = "aws-enterprise"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC."
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, false)
    type                    = optional(string, "private")
  }))
  description = "Subnet definitions."
}

variable "ingress_rules" {
  type = list(object({
    description = optional(string)
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string))
  }))
  description = "Security group ingress rules."
  default     = []
}

variable "instances" {
  type = map(object({
    instance_type = string
    subnet_key    = string
  }))
  description = "Instances map."
  default     = {}
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2."
  default     = "ami-0c55b159cbfafe1f0"
}

variable "enable_multi_az" {
  type        = bool
  description = "Enable Multi-AZ RDS."
  default     = false
}
