# AWS Environment: TEST

Deployment root module for `test` environment in region `us-east-1`.

## Deployment Steps

```bash
terraform init
terraform validate
terraform plan -out=test.tfplan
terraform apply test.tfplan
```
