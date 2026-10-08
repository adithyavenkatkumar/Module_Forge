terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-eastus"
    storage_account_name = "sttfstateeastus001"
    container_name       = "tfstate"
    key                  = "root-azure.terraform.tfstate"
  }
}
