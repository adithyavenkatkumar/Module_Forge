resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, { ManagedBy = "terraform" })

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    public_ip_address_id          = lookup(each.value, "public_ip_id", null)
  }
}

resource "azurerm_network_interface_security_group_association" "assoc" {
  for_each                  = { for k, v in var.nics : k => v if lookup(v, "nsg_id", null) != null }
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = each.value.nsg_id
}
