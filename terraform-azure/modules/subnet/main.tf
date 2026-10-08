resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                              = each.key
  resource_group_name               = var.resource_group_name
  virtual_network_name              = var.virtual_network_name
  address_prefixes                  = each.value.address_prefixes
  service_endpoints                 = lookup(each.value, "service_endpoints", [])
  private_endpoint_network_policies = lookup(each.value, "private_endpoint_network_policies", "Enabled")

  dynamic "delegation" {
    for_each = lookup(each.value, "delegations", [])
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = lookup(delegation.value, "actions", [])
      }
    }
  }
}
