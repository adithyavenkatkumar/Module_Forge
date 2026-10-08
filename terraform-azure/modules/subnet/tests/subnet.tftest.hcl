run "validate_subnet" {
  command = plan

  variables {
    resource_group_name  = "rg-test"
    virtual_network_name = "vnet-test"
    subnets = {
      "app" = {
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }

  assert {
    condition     = contains(keys(var.subnets), "app")
    error_message = "Subnet key not found"
  }
}
