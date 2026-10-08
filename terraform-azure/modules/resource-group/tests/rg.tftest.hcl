run "validate_rg_creation" {
  command = plan

  variables {
    name     = "rg-test-validation"
    location = "eastus"
    tags = {
      Environment = "test"
    }
  }

  assert {
    condition     = azurerm_resource_group.rg.name == "rg-test-validation"
    error_message = "Resource group name did not match expected value"
  }
}
