# Environment: DEV

Root deployment configuration for the `dev` environment.

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
   terraform plan -out=dev.tfplan
   ```

4. **Apply Deployment**
   ```bash
   terraform apply dev.tfplan
   ```
