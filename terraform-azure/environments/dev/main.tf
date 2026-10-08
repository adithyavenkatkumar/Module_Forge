# Root composition module for dev environment.
# Modules referenced locally can also be referenced via versioned Git repository, e.g.:
# source = "git::https://github.com/my-org/terraform-azure.git//modules/resource-group?ref=v1.0.0"

module "resource_group" {
  source   = "../../modules/resource-group"
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = local.vnet_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = [var.vnet_cidr]
  tags                = local.common_tags
}

module "subnet" {
  source               = "../../modules/subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name
  subnets              = var.subnets
}

module "nsg" {
  source              = "../../modules/nsg"
  name                = local.nsg_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  rules               = var.nsg_rules
  subnet_ids          = { for k, s in module.subnet.subnets : k => s.id }
  tags                = local.common_tags
}

module "route_table" {
  source              = "../../modules/route-table"
  name                = local.rt_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  routes              = var.custom_routes
  subnet_ids          = { for k, s in module.subnet.subnets : k => s.id }
  tags                = local.common_tags
}

module "public_ip" {
  source              = "../../modules/public-ip"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  public_ips          = var.public_ips
  tags                = local.common_tags
}

module "nic" {
  source              = "../../modules/nic"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  nics = {
    for k, v in var.vms : "nic-${k}" => {
      subnet_id    = module.subnet.subnets[v.subnet_key].id
      public_ip_id = v.enable_public_ip && contains(keys(module.public_ip.public_ips), "pip-${k}") ? module.public_ip.public_ips["pip-${k}"].id : null
    }
  }
  tags = local.common_tags
}

module "vm" {
  for_each                        = var.vms
  source                          = "../../modules/vm"
  name                            = "${local.vm_prefix}-${each.key}"
  resource_group_name             = module.resource_group.name
  location                        = module.resource_group.location
  size                            = each.value.size
  admin_username                  = var.admin_username
  admin_ssh_public_key            = var.admin_ssh_public_key
  disable_password_authentication = true
  network_interface_ids           = [module.nic.nics["nic-${each.key}"].id]
  tags                            = local.common_tags
}

module "key_vault" {
  source                        = "../../modules/key-vault"
  name                          = local.kv_name
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  public_network_access_enabled = var.kv_public_network_access
  tags                          = local.common_tags
}

module "storage_account" {
  source                        = "../../modules/storage-account"
  name                          = local.sa_name
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  account_tier                  = "Standard"
  account_replication_type      = var.storage_replication_type
  public_network_access_enabled = var.storage_public_network_access
  containers                    = var.storage_containers
  tags                          = local.common_tags
}

module "managed_identity" {
  source              = "../../modules/managed-identity"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  identities          = var.managed_identities
  tags                = local.common_tags
}

module "monitoring" {
  source              = "../../modules/monitoring"
  workspace_name      = local.law_name
  app_insights_name   = local.app_insights_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = local.common_tags
}
