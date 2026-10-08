run "validate_nsg" {
  command = plan

  variables {
    name                = "nsg-test"
    resource_group_name = "rg-test"
    location            = "eastus"
    rules = [
      {
        name                   = "AllowSSH"
        priority               = 200
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "22"
      }
    ]
  }

  assert {
    condition     = azurerm_network_security_group.nsg.name == "nsg-test"
    error_message = "NSG name mismatch"
  }
}
