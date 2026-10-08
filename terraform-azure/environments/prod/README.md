# Environment: PROD

Root deployment configuration for the `prod` environment.

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
   terraform plan -out=prod.tfplan
   ```

4. **Apply Deployment**
   ```bash
   terraform apply prod.tfplan
   ```
