# Multi-Cloud Enterprise Terraform Infrastructure Framework

Production-grade, modular, reusable, and secure Infrastructure as Code (IaC) framework for **Microsoft Azure** (`azurerm ~> 4.0`) and **Amazon Web Services (AWS)** (`hashicorp/aws ~> 5.0`).

This workspace provides standard multi-cloud landing zone architectures, **36 reusable child modules**, multi-environment deployments (`dev`, `test`, `staging`, `prod`, `dr`), standalone root composition modules, and zero-secret GitHub Actions CI/CD pipelines.

---

## 📂 Workspace Architecture

```
Terraform_Modules/
├── README.md                    # Master Workspace Overview & Guide
├── root-terraform-azure/        # Standalone Root Module for Azure Infrastructure
├── root-terraform-aws/          # Standalone Root Module for AWS Infrastructure
├── terraform-azure/             # Azure Infrastructure Framework & 18 Child Modules
│   ├── modules/                 # Reusable Azure Implementation Modules
│   ├── environments/            # Dev / Test / Staging / Prod / DR Environments
│   └── .github/workflows/       # Azure GitHub Actions OIDC CI/CD Pipeline
└── terraform-aws/               # AWS Infrastructure Framework & 18 Child Modules
    ├── modules/                 # Reusable AWS Implementation Modules
    ├── environments/            # Dev / Test / Staging / Prod / DR Environments
    └── .github/workflows/       # AWS GitHub Actions OIDC CI/CD Pipeline
```

---

## 🚀 Projects Overview

| Directory | Target Provider | Description | Core Purpose |
|-----------|-----------------|-------------|--------------|
| [`root-terraform-azure/`](./root-terraform-azure) | `hashicorp/azurerm` (~> 4.0) | Standalone Azure Root Module | Direct single-entry point orchestration calling reusable Azure modules. |
| [`root-terraform-aws/`](./root-terraform-aws) | `hashicorp/aws` (~> 5.0) | Standalone AWS Root Module | Direct single-entry point orchestration calling reusable AWS modules. |
| [`terraform-azure/`](./terraform-azure) | `hashicorp/azurerm` (~> 4.0) | Azure Framework & 18 Modules | Complete Azure landing zone with 18 reusable child modules & multi-env roots. |
| [`terraform-aws/`](./terraform-aws) | `hashicorp/aws` (~> 5.0) | AWS Framework & 18 Modules | Complete AWS landing zone with 18 reusable child modules & multi-env roots. |

---

## 🧱 Modules Catalog

### ☁️ Azure Child Modules (`terraform-azure/modules/`)

| Module | Description | Key Azure Resources |
|--------|-------------|---------------------|
| [`resource-group`](./terraform-azure/modules/resource-group) | Resource Groups & Governance Tagging | `azurerm_resource_group` |
| [`vnet`](./terraform-azure/modules/vnet) | Virtual Networks & Address Spaces | `azurerm_virtual_network` |
| [`subnet`](./terraform-azure/modules/subnet) | Subnets, Delegations & Service Endpoints | `azurerm_subnet` |
| [`nsg`](./terraform-azure/modules/nsg) | Network Security Groups & Rules | `azurerm_network_security_group` |
| [`route-table`](./terraform-azure/modules/route-table) | Custom Route Tables & Subnet Associations | `azurerm_route_table` |
| [`firewall`](./terraform-azure/modules/firewall) | Azure Firewall, Policies & Public IP | `azurerm_firewall` |
| [`vpn-gateway`](./terraform-azure/modules/vpn-gateway) | Site-to-Site VPN Gateway & Local GW | `azurerm_virtual_network_gateway` |
| [`public-ip`](./terraform-azure/modules/public-ip) | Standard Public IP Allocations | `azurerm_public_ip` |
| [`load-balancer`](./terraform-azure/modules/load-balancer) | Standard Load Balancer & Health Probes | `azurerm_lb` |
| [`application-gateway`](./terraform-azure/modules/application-gateway) | App Gateway v2 & Routing Rules | `azurerm_application_gateway` |
| [`nic`](./terraform-azure/modules/nic) | Network Interfaces & NSG Associations | `azurerm_network_interface` |
| [`vm`](./terraform-azure/modules/vm) | Linux VMs, OS/Data Disks & Managed Identity | `azurerm_linux_virtual_machine` |
| [`aks`](./terraform-azure/modules/aks) | AKS Cluster, Node Pools & OIDC | `azurerm_kubernetes_cluster` |
| [`storage-account`](./terraform-azure/modules/storage-account) | Storage Account, Blobs & ACLs | `azurerm_storage_account` |
| [`key-vault`](./terraform-azure/modules/key-vault) | Key Vault (RBAC mode) & Secrets | `azurerm_key_vault` |
| [`sql-database`](./terraform-azure/modules/sql-database) | SQL Server, Entra AD & Databases | `azurerm_mssql_server` |
| [`managed-identity`](./terraform-azure/modules/managed-identity) | User Assigned Identities & RBAC Roles | `azurerm_user_assigned_identity` |
| [`monitoring`](./terraform-azure/modules/monitoring) | Log Analytics & Application Insights | `azurerm_log_analytics_workspace` |

---

### 🟧 AWS Child Modules (`terraform-aws/modules/`)

| Module | Description | Key AWS Resources |
|--------|-------------|-------------------|
| [`tagging-baseline`](./terraform-aws/modules/tagging-baseline) | Naming Conventions & Baseline Tags | Standard `locals` & `default_tags` |
| [`vpc`](./terraform-aws/modules/vpc) | VPC, Internet Gateway & VPC Flow Logs | `aws_vpc`, `aws_flow_log` |
| [`subnet`](./terraform-aws/modules/subnet) | Multi-AZ Public, Private & Data Subnets | `aws_subnet` |
| [`security-group`](./terraform-aws/modules/security-group) | Security Groups & Dynamic Rules | `aws_security_group` |
| [`route-table`](./terraform-aws/modules/route-table) | Route Tables, Routes & Associations | `aws_route_table` |
| [`network-firewall`](./terraform-aws/modules/network-firewall) | AWS Network Firewall & Rule Groups | `aws_networkfirewall_firewall` |
| [`vpn`](./terraform-aws/modules/vpn) | Site-to-Site VPN, VGW & Customer GW | `aws_vpn_connection` |
| [`elastic-ip`](./terraform-aws/modules/elastic-ip) | Elastic IPs & Associations | `aws_eip` |
| [`load-balancer`](./terraform-aws/modules/load-balancer) | ALB / NLB, Target Groups & Listeners | `aws_lb` |
| [`alb-waf`](./terraform-aws/modules/alb-waf) | ALB + WAFv2 Web ACL Managed Rules | `aws_wafv2_web_acl` |
| [`eni`](./terraform-aws/modules/eni) | Elastic Network Interfaces | `aws_network_interface` |
| [`ec2`](./terraform-aws/modules/ec2) | EC2 Instance, IMDSv2, EBS & SSM Profile | `aws_instance` |
| [`eks`](./terraform-aws/modules/eks) | EKS Cluster, Node Groups, IRSA & OIDC | `aws_eks_cluster` |
| [`s3`](./terraform-aws/modules/s3) | S3 Bucket, Versioning, SSE & Public Block | `aws_s3_bucket` |
| [`kms-secrets`](./terraform-aws/modules/kms-secrets) | KMS CMKs, Aliases & Secrets Manager | `aws_kms_key`, `aws_secretsmanager_secret` |
| [`rds`](./terraform-aws/modules/rds) | RDS Database, Subnet Groups & Secrets | `aws_db_instance` |
| [`iam`](./terraform-aws/modules/iam) | IAM Roles, Policies & Instance Profiles | `aws_iam_role` |
| [`monitoring`](./terraform-aws/modules/monitoring) | CloudWatch Logs, CloudTrail & SNS | `aws_cloudwatch_log_group` |

---

## 🔐 Security & Compliance Standards

1. **Zero Hardcoded Secrets**: Secrets come from Key Vault, AWS Secrets Manager, SSM Parameter Store (SecureString), or OIDC token exchange.
2. **Identity & Role Authorization**:
   - Azure Key Vault operates in **RBAC Authorization mode** with soft-delete retention and purge protection.
   - AWS IAM uses least-privilege policy documents (`aws_iam_policy_document`), IRSA for EKS, and GitHub OIDC role assumption.
3. **Network Isolation**: Private subnets by default, IMDSv2 enforced on EC2 instances, VPC Flow Logs / Diagnostic Settings enabled.
4. **Encryption at Rest & in Transit**: TLS 1.2+ enforced, HTTPS only, customer-managed keys (CMK) for Storage, S3, EBS, RDS, and CloudWatch logs.

---

## ⚡ Deployment Guide

### Deploy Azure Root Configuration
```bash
cd root-terraform-azure
terraform init
terraform validate
terraform plan -out=azure-root.tfplan
terraform apply azure-root.tfplan
```

### Deploy AWS Root Configuration
```bash
cd root-terraform-aws
terraform init
terraform validate
terraform plan -out=aws-root.tfplan
terraform apply aws-root.tfplan
```

### Deploy Environment-Specific Stacks (`dev`, `test`, `staging`, `prod`, `dr`)
```bash
# Azure Dev Environment
cd terraform-azure/environments/dev
terraform init && terraform apply

# AWS Prod Environment
cd terraform-aws/environments/prod
terraform init && terraform apply
```

---

## 🛠 Command Cheat Sheet

| Command | Description |
|---------|-------------|
| `terraform init -backend=false` | Initializes providers and modules without connecting to remote state backends. |
| `terraform fmt -recursive` | Formats all HCL files recursively according to canonical Terraform standards. |
| `terraform validate` | Checks syntax, argument types, and module variable bindings. |
| `terraform plan -out=tfplan` | Generates execution plan diff against cloud state. |
| `terraform apply tfplan` | Applies exact planned changes deterministically. |
| `terraform output -json` | Queries state outputs in JSON format. |
| `terraform state list` | Displays all resources tracked in state backend. |
