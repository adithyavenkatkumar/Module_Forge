resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  tags                = merge(var.tags, { ManagedBy = "terraform" })

  default_node_pool {
    name                 = var.default_node_pool.name
    node_count           = var.default_node_pool.node_count
    vm_size              = var.default_node_pool.vm_size
    vnet_subnet_id       = lookup(var.default_node_pool, "vnet_subnet_id", null)
    auto_scaling_enabled = lookup(var.default_node_pool, "auto_scaling_enabled", false)
    min_count            = lookup(var.default_node_pool, "min_count", null)
    max_count            = lookup(var.default_node_pool, "max_count", null)
    os_disk_size_gb      = lookup(var.default_node_pool, "os_disk_size_gb", 128)
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  network_profile {
    network_plugin    = var.network_profile.network_plugin
    network_policy    = lookup(var.network_profile, "network_policy", null)
    load_balancer_sku = lookup(var.network_profile, "load_balancer_sku", "standard")
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "extra_pools" {
  for_each              = var.extra_node_pools
  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = lookup(each.value, "node_count", 1)
  vnet_subnet_id        = lookup(each.value, "vnet_subnet_id", null)
  auto_scaling_enabled  = lookup(each.value, "auto_scaling_enabled", false)
  min_count             = lookup(each.value, "min_count", null)
  max_count             = lookup(each.value, "max_count", null)
  tags                  = merge(var.tags, { ManagedBy = "terraform" })
}
