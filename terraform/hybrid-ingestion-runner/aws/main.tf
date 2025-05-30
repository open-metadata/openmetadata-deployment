locals {
  namespace = "${var.namespace}-${var.environment}"
  image_tag = "om-${var.release_version}-cl-${var.release_version}"
}

resource "helm_release" "hybrid_runner" {
  name       = "hybrid-ingestion-runner"
  repository = "https://open-metadata.github.io/hybrid-ingestion-runner-helm-chart"
  chart      = "hybrid-ingestion-runner"
  version    = var.release_version
  namespace  = local.namespace
  wait       = false
  values = [
    templatefile("${path.module}/helm_values.tftpl",
      {
        image_tag                = local.image_tag
        environment              = var.environment
        docker_image_repository  = var.docker_image_repository
        docker_image_tag         = var.docker_image_tag
        docker_image_pull_secret = var.docker_image_pull_secret
        docker_image_pull_policy = var.docker_image_pull_policy
        agent_id                 = var.runner_id
        collate_auth_token       = var.collate_auth_token
        collate_server_domain    = var.collate_server_domain
        service_monitor_enabled  = var.service_monitor_enabled
        ingestion                = var.ingestion
        ingestion_role_arn       = module.ingestion_pods_irsa.iam_role_arn
        argowf                   = local.argowf
      }
    )
  ]
  depends_on = [
    kubernetes_namespace.hybrid_runner
  ]
}
