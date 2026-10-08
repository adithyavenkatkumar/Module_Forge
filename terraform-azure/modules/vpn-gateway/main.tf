resource "azurerm_public_ip" "pip" {
  name                = "${var.name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}

resource "azurerm_virtual_network_gateway" "vpn" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  type                = var.type
  vpn_type            = var.vpn_type
  active_active       = false
  enable_bgp          = false
  sku                 = var.sku
  tags                = merge(var.tags, { ManagedBy = "terraform" })

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
}

resource "azurerm_local_network_gateway" "local_gw" {
  for_each            = var.local_network_gateways
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = each.value.gateway_address
  address_space       = each.value.address_space
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}

resource "azurerm_virtual_network_gateway_connection" "conn" {
  for_each                   = var.local_network_gateways
  name                       = "${var.name}-conn-${each.key}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gw[each.key].id
  shared_key                 = var.shared_key
  tags                       = merge(var.tags, { ManagedBy = "terraform" })
}
