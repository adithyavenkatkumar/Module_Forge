# Standalone Root Module for AWS Infrastructure (`root-terraform-aws`)

This directory serves as a complete standalone **Root Module** for deploying enterprise AWS infrastructure. It calls and orchestrates reusable child modules defined in `../terraform-aws/modules/`.

## Structure

```
root-terraform-aws/
├── main.tf          # Calls child modules (tagging, vpc, subnet, sg, route-table, kms-secrets, s3, iam, ec2, monitoring)
├── providers.tf     # AWS provider configuration
├── versions.tf      # Provider version constraints (~> 5.0)
├── variables.tf     # Root-level typed inputs
├── outputs.tf       # Exported resource identifiers and ARNs
├── locals.tf        # Naming convention & tag generation
├── backend.tf       # Remote state configuration in AWS S3 + DynamoDB locking
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
terraform plan -out=aws-root.tfplan

# 4. Apply configuration
terraform apply aws-root.tfplan
```
