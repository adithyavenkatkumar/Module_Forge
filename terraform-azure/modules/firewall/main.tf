resource "azurerm_public_ip" "pip" {
  count               = var.public_ip_id == null ? 1 : 0
  name                = "${var.name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}

resource "azurerm_firewall_policy" "policy" {
  count               = var.firewall_policy_id == null ? 1 : 0
  name                = "${var.name}-policy"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_tier
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}

resource "azurerm_firewall" "fw" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  firewall_policy_id  = var.firewall_policy_id != null ? var.firewall_policy_id : azurerm_firewall_policy.policy[0].id
  tags                = merge(var.tags, { ManagedBy = "terraform" })

  ip_configuration {
    name                 = "fw-ip-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_id != null ? var.public_ip_id : azurerm_public_ip.pip[0].id
  }
}
