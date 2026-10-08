variable "identifier" {
  type        = string
  description = "RDS DB Instance Identifier."
}

variable "engine" {
  type        = string
  description = "Database engine."
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Engine version."
  default     = "15.4"
}

variable "family" {
  type        = string
  description = "Parameter Group Family."
  default     = "postgres15"
}

variable "instance_class" {
  type        = string
  description = "Instance class."
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Storage in GB."
  default     = 20
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for DB Subnet Group."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security Group IDs."
  default     = []
}

variable "database_name" {
  type        = string
  description = "Initial database name."
  default     = "appdb"
}

variable "admin_username" {
  type        = string
  description = "Master username."
  default     = "dbadmin"
}

variable "admin_password" {
  type        = string
  description = "Master password if manage_master_user_password is false."
  sensitive   = true
  default     = null
}

variable "manage_master_user_password" {
  type        = bool
  description = "Use AWS Secrets Manager for master user password."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key ID/ARN for encryption."
  default     = null
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment."
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on deletion."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
