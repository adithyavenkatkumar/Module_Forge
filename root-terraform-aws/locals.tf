locals {
  naming_prefix = "${var.workload}-${var.environment}-${var.region}"

  vpc_name  = "vpc-${local.naming_prefix}-001"
  sg_name   = "sg-${local.naming_prefix}-web-001"
  rt_name   = "rt-${local.naming_prefix}-001"
  kms_alias = "kms-${var.workload}-${var.environment}"
  s3_name   = "s3-${var.workload}-${var.environment}-data-99201"

  common_tags = {
    Environment = var.environment
    Workload    = var.workload
    Owner       = var.owner
    CostCenter  = var.cost_center
    Project     = var.project
    ManagedBy   = "terraform"
  }
}
