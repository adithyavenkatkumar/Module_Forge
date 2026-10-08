resource "azurerm_lb" "lb" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  tags                = merge(var.tags, { ManagedBy = "terraform" })

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations
    content {
      name                          = frontend_ip_configuration.key
      public_ip_address_id          = lookup(frontend_ip_configuration.value, "public_ip_address_id", null)
      subnet_id                     = lookup(frontend_ip_configuration.value, "subnet_id", null)
      private_ip_address            = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      private_ip_address_allocation = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", "Dynamic")
    }
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  for_each        = var.backend_pools
  name            = each.key
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.probes
  name            = each.key
  loadbalancer_id = azurerm_lb.lb.id
  port            = each.value.port
  protocol        = lookup(each.value, "protocol", "Tcp")
  request_path    = lookup(each.value, "request_path", null)
}

resource "azurerm_lb_rule" "rule" {
  for_each                       = var.rules
  name                           = each.key
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  protocol                       = lookup(each.value, "protocol", "Tcp")
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool[each.value.backend_pool_name].id]
  probe_id                       = lookup(each.value, "probe_name", null) != null ? azurerm_lb_probe.probe[each.value.probe_name].id : null
}
