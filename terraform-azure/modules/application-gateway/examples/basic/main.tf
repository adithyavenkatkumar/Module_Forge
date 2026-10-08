module "rg" {
  source   = "../../../resource-group"
  name     = "rg-appgw-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../../vnet"
  name                = "vnet-appgw-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "subnets" {
  source               = "../../../subnet"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  subnets = {
    "AppGwSubnet" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

module "pip" {
  source              = "../../../public-ip"
  resource_group_name = module.rg.name
  location            = module.rg.location
  public_ips = {
    "pip-appgw" = { allocation_method = "Static", sku = "Standard" }
  }
}

module "appgw" {
  source              = "../../"
  name                = "appgw-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnets.subnets["AppGwSubnet"].id

  frontend_ports = [
    { name = "http-port", port = 80 }
  ]

  frontend_ip_configurations = [
    { name = "frontend-ip", public_ip_address_id = module.pip.public_ips["pip-appgw"].id }
  ]

  backend_pools = [
    { name = "default-backend", ip_addresses = ["10.0.2.4"] }
  ]

  backend_http_settings = [
    { name = "http-settings", port = 80, protocol = "Http" }
  ]

  http_listeners = [
    { name = "http-listener", frontend_ip_configuration_name = "frontend-ip", frontend_port_name = "http-port", protocol = "Http" }
  ]

  request_routing_rules = [
    {
      name                       = "rule1"
      http_listener_name         = "http-listener"
      backend_address_pool_name  = "default-backend"
      backend_http_settings_name = "http-settings"
      priority                   = 10
    }
  ]
}
