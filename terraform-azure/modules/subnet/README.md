# Subnet Module

Manages Azure Subnets with delegation and service endpoints support using `for_each`.

## Usage
```hcl
module "subnets" {
  source               = "../../modules/subnet"
  resource_group_name  = "rg-dev-eastus"
  virtual_network_name = "vnet-dev-eastus"
  subnets = {
    "web" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}
```
