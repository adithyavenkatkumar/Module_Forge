# Environment: STAGING

Root deployment configuration for the `staging` environment.

## Deployment Instructions

1. **Initialize Backend**
   ```bash
   terraform init
   ```

2. **Validate Configuration**
   ```bash
   terraform validate
   ```

3. **Generate & Inspect Plan**
   ```bash
   terraform plan -out=staging.tfplan
   ```

4. **Apply Deployment**
   ```bash
   terraform apply staging.tfplan
   ```
