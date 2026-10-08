# AWS Environment: PROD

Deployment root module for `prod` environment in region `us-east-1`.

## Deployment Steps

```bash
terraform init
terraform validate
terraform plan -out=prod.tfplan
terraform apply prod.tfplan
```
