locals {
  naming_prefix = "${var.workload}-${var.environment}-${var.location}"

  rg_name           = "rg-${local.naming_prefix}-001"
  vnet_name         = "vnet-${local.naming_prefix}-001"
  nsg_name          = "nsg-${local.naming_prefix}-001"
  rt_name           = "rt-${local.naming_prefix}-001"
  vm_prefix         = "vm-${var.workload}-${var.environment}"
  kv_name           = "kv-${var.workload}-${var.environment}-001"
  sa_name           = "st${var.workload}${var.environment}001"
  law_name          = "law-${local.naming_prefix}-001"
  app_insights_name = "appi-${local.naming_prefix}-001"

  common_tags = {
    Environment = var.environment
    Workload    = var.workload
    Owner       = var.owner
    CostCenter  = var.cost_center
    Project     = var.project
    ManagedBy   = "terraform"
  }
}
