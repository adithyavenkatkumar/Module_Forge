# AWS Environment: DR

Deployment root module for `dr` environment in region `us-west-2`.

## Deployment Steps

```bash
terraform init
terraform validate
terraform plan -out=dr.tfplan
terraform apply dr.tfplan
```
