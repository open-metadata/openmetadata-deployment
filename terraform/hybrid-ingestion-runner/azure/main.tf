locals {
  namespace = "${var.namespace}-${var.environment}"
  runner_id = coalesce(try(var.runner_id, null), "azure-${var.environment}-hybrid-ingestion-runner")
  argowf = {
    provisioner = coalesce(try(var.argowf.provisioner, null), "helm")
    endpoint    = try(var.argowf.endpoint, null)
  }
}

resource "kubernetes_namespace" "hybrid_runner" {
  metadata {
    name = local.namespace
  }
}

resource "kubernetes_namespace" "argo_workflows" {
  count = local.argowf.provisioner == "helm" ? 1 : 0
  metadata {
    name = "argo-workflows"
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
      ecr_access_key           = var.ECR_ACCESS_KEY
      ecr_secret_key           = var.ECR_SECRET_KEY
    })
  ]

  depends_on = [
    kubernetes_namespace.hybrid_runner,
    kubernetes_namespace.argo_workflows
  ]
}