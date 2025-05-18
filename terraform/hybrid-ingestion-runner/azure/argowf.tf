# Argo Workflows resources and persistence

resource "kubernetes_namespace" "argowf" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  metadata {
    name = local.argowf.namespace
  }
}

resource "helm_release" "argowf" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  name       = "argowf-${var.environment}"
  namespace  = kubernetes_namespace.argowf["this"].metadata[0].name
  chart      = "argo-workflows"
  version    = local.argowf.helm_chart_version
  repository = "https://argoproj.github.io/argo-helm"
  values = [
    templatefile("${path.module}/argowf_helm_values.tftpl", {
      fullname_override    = "argo-workflows-${var.environment}"
      db_host              = azurerm_postgresql_flexible_server.argowf.fqdn
      controller_client_id = azuread_service_principal.argowf_controller.app_id
      server_client_id     = azuread_service_principal.argowf_server.app_id
      argowf               = local.argowf
    })
  ]
}

# PostgreSQL Flexible Server for Argo persistence
resource "random_password" "argowf_db_password" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  length           = 16
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

resource "azurerm_postgresql_flexible_server" "argowf" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  name                   = local.argowf.db.credentials_secret
  resource_group_name    = var.aks_resource_group_name
  location               = var.location
  version                = local.argowf.db.version
  administrator_login    = local.argowf.db.administrator_login
  administrator_password = random_password.argowf_db_password["this"].result
  sku_name               = local.argowf.db.sku_name
  storage_mb             = local.argowf.db.storage_mb
  backup_retention_days  = local.argowf.db.backup_retention_days
  geo_redundant_backup   = local.argowf.db.geo_redundant_backup
  auto_grow_enabled      = local.argowf.db.auto_grow_enabled

  depends_on = [azurerm_storage_account.argowf]
}

# Kubernetes secret to provide DB credentials to Argo
resource "kubernetes_secret" "argowf_db_credentials" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  metadata {
    name      = local.argowf.db.credentials_secret
    namespace = kubernetes_namespace.argowf["this"].metadata[0].name
  }
  data = {
    username = local.argowf.db.administrator_login
    password = random_password.argowf_db_password["this"].result
  }
}