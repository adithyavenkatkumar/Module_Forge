# Virtual Network Module

Manages Azure Virtual Networks (VNet).

## Usage
```hcl
module "vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-dev-eastus"
  resource_group_name = "rg-dev-eastus-001"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
}
```
