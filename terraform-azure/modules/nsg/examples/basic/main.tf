module "rg" {
  source   = "../../../resource-group"
  name     = "rg-nsg-example"
  location = "eastus"
}

module "nsg" {
  source              = "../../"
  name                = "nsg-example-basic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  rules = [
    {
      name                   = "AllowHTTPS"
      priority               = 100
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "443"
    }
  ]
}
