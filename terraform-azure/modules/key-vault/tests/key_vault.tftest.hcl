run "validate_key_vault" {
  command = plan

  variables {
    name                          = "kv-test-validation"
    resource_group_name           = "rg-test"
    location                      = "eastus"
    public_network_access_enabled = false
  }

  assert {
    condition     = azurerm_key_vault.kv.name == "kv-test-validation"
    error_message = "Key Vault name mismatch"
  }
}
