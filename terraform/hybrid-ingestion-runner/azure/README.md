# Terraform project for deploying Collate Ingestion Runner in Azure

## Prerequisites

- Administrator access on the Azure subscription and AKS cluster
- An existing AKS cluster (version >= 1.28) with workload identity (OIDC) enabled
- Terraform >= 1.0
- Azure CLI installed and authenticated

## Usage

Create a `terraform.tfvars` file with your settings. For example:
```hcl
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
release_version          = "1.7.0"
namespace                = "collate-hybrid-ingestion-runner"
docker_image_repository  = "public.ecr.aws/118146679784/hybrid-ingestion-runner"
docker_image_tag         = "latest"
docker_image_pull_secret = "registry-secret"
runner_id                = "runner-1"
service_monitor_enabled  = false

# AWS ECR credentials (for private image pull)
ECR_ACCESS_KEY = "<ECR access key>"
ECR_SECRET_KEY = "<ECR secret key>"

# Argo Workflows configuration
argowf = {
  provisioner           = "helm"
  helm_chart_version    = "0.40.8"
  namespace             = "argo-workflows-sandbox"
  controller_sa_name    = "argo-workflows-controller"
  server_sa_name        = "argo-workflows-server"
  storage_account_name  = "argowfstorage-sandbox"
  storage_container_name = "argo-workflows-sandbox"
  crd_enabled           = true
  db = {
    sku_name               = "Standard_B1ms"
    version                = "12"
    administrator_login    = "dbadmin"
    credentials_secret     = "argowf-db-sandbox"
    storage_mb             = 512
    backup_retention_days  = 7
    geo_redundant_backup   = false
    auto_grow_enabled      = true
  }
}
```

Run:
```bash
terraform init && terraform apply
```

For full Terraform reference, see [README_terraform.md](README_terraform.md)