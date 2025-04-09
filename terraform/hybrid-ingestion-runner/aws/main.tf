resource "helm_release" "hybrid_runner" {
  name  = "hybrid-ingestion-runner"
  #chart = "/home/andres/projects/collate/hybrid-ingestion-agent-helm-chart/charts/hybrid-ingestion-runner"
  repository = "https://open-metadata.github.io/hybrid-ingestion-runner-helm-chart"
  chart      = "hybrid-ingestion-runner"
  version   = var.release_version
  namespace = var.namespace
  wait      = false
  values = [
    templatefile("${path.module}/helm_values.tftpl",
      {
        docker_image_repository = var.docker_image_repository
        docker_image_tag        = var.docker_image_tag
        agent_id                = var.runner_id
        collate_auth_token      = var.collate_auth_token
        collate_server_url      = var.collate_server_url
        service_monitor_enabled = var.service_monitor_enabled
        ingestion               = var.ingestion
        argowf                  = local.argowf
      }
    )
  ]
}
