# Resource Group Module

This module manages Azure Resource Groups with standard governance tagging.

## Requirements
- Terraform >= 1.5.0
- azurerm provider ~> 4.0

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Resource Group Name | `string` | n/a | yes |
| location | Azure Region | `string` | `"eastus"` | no |
| tags | Tags map | `map(string)` | `{}` | no |

## Outputs
| Name | Description |
|------|-------------|
| id | Resource Group ID |
| name | Resource Group Name |
| location | Azure Region |

## Usage
```hcl
module "resource_group" {
  source   = "../../modules/resource-group"
  name     = "rg-dev-eastus-001"
  location = "eastus"
  tags = {
    Environment = "dev"
  }
}
```
