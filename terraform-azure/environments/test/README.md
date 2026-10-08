# Environment: TEST

Root deployment configuration for the `test` environment.

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
   terraform plan -out=test.tfplan
   ```

4. **Apply Deployment**
   ```bash
   terraform apply test.tfplan
   ```
