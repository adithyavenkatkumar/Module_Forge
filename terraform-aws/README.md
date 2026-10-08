# AWS Terraform Infrastructure Framework (`terraform-aws`)

Production-grade, modular Terraform framework for AWS infrastructure management across multi-environment setups (`dev`, `test`, `staging`, `prod`, `dr`). Built adhering to AWS Well-Architected Framework and Terraform Best Practices.

---

## 🏗 Architecture Overview

The project is structured into **18 Reusable Child Modules** (`modules/`) and **5 Environment Root Modules** (`environments/`).

```
terraform-aws/
├── modules/                          # Reusable implementation child modules
│   ├── tagging-baseline/             # Standard Tags & Naming Convention Helpers
│   ├── vpc/                          # VPC, CIDRs, Internet Gateway, VPC Flow Logs
│   ├── subnet/                       # Public/Private/Data Subnets across AZs
│   ├── security-group/               # Security Groups & Dynamic Ingress/Egress Rules
│   ├── route-table/                  # Route Tables, Routes & Subnet Associations
│   ├── network-firewall/             # AWS Network Firewall, Policies & Endpoints
│   ├── vpn/                          # Site-to-Site VPN: Gateway, Customer GW & Connections
│   ├── elastic-ip/                   # Elastic IPs & Associations
│   ├── load-balancer/                # NLB/ALB, Target Groups, Listeners & Health Checks
│   ├── alb-waf/                      # Application Load Balancer + WAFv2 Web ACL
│   ├── eni/                          # Network Interfaces & Subnet/SG Associations
│   ├── ec2/                          # EC2 Instances, EBS Volumes, IMDSv2 & SSM Profile
│   ├── eks/                          # EKS Cluster, Node Groups, IRSA & OIDC Provider
│   ├── s3/                           # S3 Bucket, Versioning, SSE, Public Access Block
│   ├── kms-secrets/                  # KMS CMKs, Aliases, Secrets Manager & SSM Params
│   ├── rds/                          # RDS PostgreSQL/MySQL, Subnet Groups & Secrets
│   ├── iam/                          # IAM Roles, Policies, Instance Profiles & OIDC
│   └── monitoring/                   # CloudWatch Logs, CloudTrail & SNS Alerts
├── environments/                     # Environment Root Composition Modules
│   ├── dev/                          # Development Environment (10.100.0.0/16, us-east-1)
│   ├── test/                         # Test Environment (10.110.0.0/16, us-east-1)
│   ├── staging/                      # Staging Environment (10.120.0.0/16, us-east-1)
│   ├── prod/                         # Production Environment (10.130.0.0/16, Multi-AZ)
│   └── dr/                           # Disaster Recovery Environment (10.140.0.0/16, us-west-2)
├── .github/workflows/                # CI/CD Pipeline (GitHub Actions + AWS OIDC)
├── .gitignore                        # Standard Git Ignore for Secrets and State
├── .terraform-docs.yml               # Documentation Generator Config
└── README.md                         # Framework Architecture & Command Cheat Sheet
```

---

## 🛡 Security & Governance Principles

1. **Zero Hardcoded Secrets**: Secrets come from AWS Secrets Manager / SSM Parameter Store (SecureString) or OIDC authentication.
2. **Network Isolation**: Private subnets by default, IMDSv2 enforced on EC2 instances, VPC Flow Logs enabled.
3. **Encryption Everywhere**: AWS KMS Customer Managed Keys (CMKs) with key rotation enabled for S3, EBS, RDS, CloudWatch logs, and Secrets Manager.
4. **Least Privilege IAM**: Managed policies using `aws_iam_policy_document` data sources, IRSA for EKS, and GitHub OIDC role assumption.

---

## 🚀 How to Deploy per Environment

### Step 1: Initialize Backend & Modules
```bash
cd environments/dev  # Or test, staging, prod, dr
terraform init
```

### Step 2: Format & Validate Code
```bash
terraform fmt
terraform validate
```

### Step 3: Run Plan
```bash
terraform plan -out=dev.tfplan
```

### Step 4: Apply Plan
```bash
terraform apply dev.tfplan
```

---

## 💡 Terraform Command Cheat Sheet

| Command | Real-World Use Case |
|---------|---------------------|
| `terraform init -backend-config="key=env.tfstate"` | Initializes working directory, downloads AWS provider (~> 5.0), configures remote S3 state backend. |
| `terraform fmt -recursive` | Formats all HCL files recursively according to canonical standards. |
| `terraform validate` | Validates syntax, argument types, and module variable bindings offline. |
| `terraform plan -out=tfplan` | Computes execution plan diff against AWS infrastructure state and saves plan file. |
| `terraform apply tfplan` | Executes planned changes against target AWS infrastructure. |
| `terraform show tfplan` | Inspects execution plan contents or active backend state file. |
| `terraform output -json` | Queries and outputs state values in JSON format for automation scripts. |
| `terraform state list` | Displays all resources tracked in remote S3 backend state. |
| `terraform state rm <resource_address>` | Removes resource binding from state without deleting physical AWS resource. |
| `terraform import <resource_address> <aws_resource_id>` | Imports pre-existing AWS resource into Terraform state tracking. |
| `terraform destroy -target=<resource_address>` | Destroys specific target resource or complete environment infrastructure stack. |
