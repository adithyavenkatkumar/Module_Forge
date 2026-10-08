locals {
  naming_prefix = "${var.workload}-${var.environment}-${var.region}"

  standard_tags = merge({
    Environment = var.environment
    Workload    = var.workload
    Owner       = var.owner
    CostCenter  = var.cost_center
    Project     = var.project
    ManagedBy   = "terraform"
  }, var.extra_tags)
}
