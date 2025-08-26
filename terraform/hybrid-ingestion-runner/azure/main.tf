locals {
  namespace = "${var.namespace}-${var.environment}"
  runner_id = coalesce(try(var.runner_id, null), "azure-${var.environment}-hybrid-ingestion-runner")
}

resource "kubernetes_namespace" "hybrid_runner" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "hybrid_runner" {
  name       = "hybrid-ingestion-runner"
  repository = "https://open-metadata.github.io/hybrid-ingestion-runner-helm-chart"
  chart      = "hybrid-ingestion-runner"
  version    = var.release_version
  namespace  = local.namespace
  wait       = false
  values = [
    templatefile("${path.module}/helm_values.tftpl", {
      environment              = var.environment
      docker_image_repository  = var.docker_image_repository
      docker_image_tag         = var.docker_image_tag
      docker_image_pull_secret = var.docker_image_pull_secret
      agent_id                 = local.runner_id
      collate_auth_token       = var.collate_auth_token
      collate_server_domain    = var.collate_server_domain
      service_monitor_enabled  = var.service_monitor_enabled
      ingestion                = var.ingestion
      ingestion_client_id      = azurerm_user_assigned_identity.ingestion.client_id
      argowf                   = local.argowf
      azure_key_vault_name     = var.key_vault_name
    })
  ]

  depends_on = [
    kubernetes_namespace.hybrid_runner,
    helm_release.argowf
  ]
}