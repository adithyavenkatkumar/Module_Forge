# Azure Terraform Infrastructure Framework (`terraform-azure`)

Production-grade, modular Terraform framework for Azure infrastructure management across multi-environment setups (`dev`, `test`, `staging`, `prod`, `dr`). Built adhering to Microsoft Azure Landing Zone standards and Terraform Best Practices.

---

## 🏗 Architecture Overview

The project is structured into **18 Reusable Child Modules** (`modules/`) and **5 Environment Root Modules** (`environments/`).

```
terraform-azure/
├── modules/                   # Reusable implementation child modules
│   ├── resource-group/        # Azure Resource Groups + Tagging Governance
│   ├── vnet/                  # Virtual Network & Address Spaces
│   ├── subnet/                # Subnets, Delegations, Service Endpoints
│   ├── nsg/                   # NSGs, Dynamic Security Rules & Associations
│   ├── route-table/           # Route Tables & Custom Route Rules
│   ├── firewall/              # Azure Firewall, Firewall Policy & PIP
│   ├── vpn-gateway/           # Site-to-Site VPN Gateway & Local Gateways
│   ├── public-ip/             # Public IP Allocations
│   ├── load-balancer/         # Standard Load Balancer & Health Probes
│   ├── application-gateway/   # Application Gateway v2 (WAF / Routing)
│   ├── nic/                   # Network Interfaces & Security Associations
│   ├── vm/                    # Linux VMs, OS/Data Disks, SSH Keys
│   ├── aks/                   # AKS Cluster, Node Pools, RBAC & Networking
│   ├── storage-account/       # Storage Account, Blob Containers & ACLs
│   ├── key-vault/             # Key Vault, RBAC Mode, Secrets & Private Endpoints
│   ├── sql-database/          # Azure SQL Server, Entra AD Auth & Databases
│   ├── managed-identity/      # User Assigned Identities & RBAC Role Assignments
│   └── monitoring/            # Log Analytics Workspace & App Insights
├── environments/              # Environment Root Composition Modules
│   ├── dev/                   # Development Environment Configuration
│   ├── test/                  # Test Environment Configuration
│   ├── staging/               # Staging Environment Configuration
│   ├── prod/                  # Production Environment Configuration
│   └── dr/                    # Disaster Recovery Environment Configuration
├── .github/workflows/         # CI/CD Pipeline Configuration (OIDC, Matrix, Security)
├── .gitignore                 # Standard Git Ignore for Secrets and State
├── .terraform-docs.yml        # Documentation Generator Config
└── README.md                  # Project Documentation
```

---

## 🛡 Security & Governance Principles

1. **Zero Secrets in Git**: Sensitive values (`admin_password`, `shared_key`, `secrets`) are passed via Key Vault, OIDC, or environment variables (`TF_VAR_*`).
2. **Network Isolation**: Default Deny-all posture, Private Endpoints for Key Vault and Storage, Public Network Access disabled by default for Production.
3. **Encryption**: Enforced minimum TLS 1.2, HTTPS only, customer-managed keys (CMK) ready.
4. **RBAC & OIDC**: Key Vault operates in RBAC mode; CI/CD pipeline authenticates via Azure AD Workload Identity Federation (OIDC).

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
| `terraform init -backend-config="key=env.tfstate"` | Initializes working directory, downloads providers/modules, configures remote storage state backend. |
| `terraform fmt -recursive` | Formats all HCL code recursively according to canonical standards. |
| `terraform validate` | Validates syntax, attribute names, and reference integrity without connecting to cloud APIs. |
| `terraform plan -out=tfplan` | Computes execution diff against cloud state and saves execution plan artifact. |
| `terraform apply tfplan` | Applies exact planned changes deterministically to target infrastructure. |
| `terraform show tfplan` | Displays human-readable contents of a saved plan artifact or current state. |
| `terraform output -json` | Queries and extracts outputs from state file in JSON format for automation scripts. |
| `terraform state list` | Lists all tracked resources inside remote backend state file. |
| `terraform state rm <resource_address>` | Unbinds resource from state tracking without deleting physical Azure resource. |
| `terraform import <resource_address> <azure_resource_id>` | Imports existing Azure infrastructure resource into Terraform state. |
| `terraform destroy -target=<resource_address>` | Safely teardowns specific target resource or complete environment infrastructure. |
