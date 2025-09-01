# Terraform project for deploying Collate Ingestion Runner in Azure

## Prerequisites

- Administrator access on the Azure subscription and AKS cluster
- An existing AKS cluster (version >= 1.28) with workload identity (OIDC) enabled
- Terraform >= 1.0
- Existing Azure Key Vault in same resource group as AKS or different resource group
- Azure CLI installed and authenticated

## Usage

Create a `terraform.tfvars` file with your settings. For example:
```hcl
# AKS Details
subscription_id = "azure-subscription-id"

# AKS cluster details
aks_resource_group_name = "aks-resource-group"
aks_cluster_name        = "aks-cluster"

# Azure location
location = "westeurope"

# Environment (used to suffix namespaces/resources)
environment = "sandbox"

# Collate runner settings
collate_auth_token   = "YOUR_COLLATE_TOKEN"
collate_server_domain = "my-company.getcollate.io"

# Hybrid Ingestion Runner settings
release_version          = "1.9.5"
service_monitor_enabled  = false

# AWS ECR credentials (for private image pull)
ECR_ACCESS_KEY = "<ECR access key>"
ECR_SECRET_KEY = "<ECR secret key>"

# Azure Key Vault name
key_vault_name = "azure-key-vault-name"
key_vault_resource_group_name = "azure-key-vault-resource-group-name"
```

Run:
```bash
terraform init && terraform apply
```

For full Terraform reference, see [README_terraform.md](README_terraform.md)