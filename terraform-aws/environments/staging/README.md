# AWS Environment: STAGING

Deployment root module for `staging` environment in region `us-east-1`.

## Deployment Steps

```bash
terraform init
terraform validate
terraform plan -out=staging.tfplan
terraform apply staging.tfplan
```
