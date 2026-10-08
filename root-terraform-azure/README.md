# Standalone Root Module for Azure Infrastructure (`root-terraform-azure`)

This directory serves as a complete standalone **Root Module** for deploying enterprise Azure infrastructure. It calls and orchestrates reusable child modules defined in `../terraform-azure/modules/`.

## Structure

```
root-terraform-azure/
├── main.tf          # Calls child modules (rg, vnet, subnet, nsg, route-table, pip, nic, vm, kv, storage, identity, monitoring)
├── providers.tf     # azurerm provider configuration
├── versions.tf      # Provider version constraints (~> 4.0)
├── variables.tf     # Root-level typed inputs
├── outputs.tf       # Exported resource identifiers and endpoints
├── locals.tf        # Naming convention & tag generation
├── backend.tf       # Remote state configuration in Azure Blob Storage
├── terraform.tfvars # Production parameters
└── README.md        # Documentation
```

## Deployment Commands

```bash
# 1. Initialize backend and modules
terraform init

# 2. Validate configuration
terraform validate

# 3. Create execution plan
terraform plan -out=azure-root.tfplan

# 4. Apply configuration
terraform apply azure-root.tfplan
```
