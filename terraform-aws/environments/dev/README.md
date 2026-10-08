# AWS Environment: DEV

Deployment root module for `dev` environment in region `us-east-1`.

## Deployment Steps

```bash
terraform init
terraform validate
terraform plan -out=dev.tfplan
terraform apply dev.tfplan
```
