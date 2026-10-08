run "validate_vnet" {
  command = plan

  variables {
    name                = "vnet-test"
    resource_group_name = "rg-test"
    location            = "eastus"
    address_space       = ["10.0.0.0/16"]
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "vnet-test"
    error_message = "VNet name did not match"
  }
}
