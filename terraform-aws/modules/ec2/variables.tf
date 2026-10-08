variable "name" {
  type        = string
  description = "Instance name."
}

variable "ami_id" {
  type        = string
  description = "AMI ID."
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type."
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of Security Group IDs."
  default     = []
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM Instance Profile Name."
  default     = null
}

variable "user_data" {
  type        = string
  description = "User data script content."
  default     = null
}

variable "root_block_device" {
  type = object({
    volume_type = optional(string, "gp3")
    volume_size = optional(number, 20)
    kms_key_id  = optional(string)
  })
  description = "Root block device config."
  default     = {}
}

variable "ebs_volumes" {
  type = map(object({
    size        = number
    device_name = string
    type        = optional(string, "gp3")
    kms_key_id  = optional(string)
  }))
  description = "Additional EBS volumes map."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
