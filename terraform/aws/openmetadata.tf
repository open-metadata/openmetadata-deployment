locals {
  omd = {
    namespace          = var.app_namespace
    helm_chart_version = coalesce(var.app_helm_chart_version, var.app_version)
    docker_image_tag   = coalesce(var.docker_image_tag, "om-${var.app_version}-cl-${var.app_version}")
    server_sa_name     = "openmetadata-server"
  }
  className                   = "io.collate.pipeline.argo.ArgoServiceClient"
  apiEndpoint                 = "http://argowf-argo-workflows-server:2746"
  metadataApiEndpoint         = "http://openmetadata:8585/api"
  imagePullPolicy             = "IfNotPresent"
  argoServiceAccountTokenName = "om-argo-wf-sa.service-account-token"
}


# OpenMetadata application resources

resource "kubernetes_namespace" "app" {
  metadata {
    annotations = {
      name = local.omd.namespace
    }
    name = local.omd.namespace
  }
}

resource "helm_release" "openmetadata" {
  name       = "openmetadata"
  repository = "https://helm.open-metadata.org"
  chart      = "openmetadata"
  version    = local.omd.helm_chart_version
  namespace  = kubernetes_namespace.app.id
  wait       = false
  values = [
    templatefile("${path.module}/helm-dependencies/openmetadata_config.tftpl",
      {
        namespace                     = local.omd.namespace
        image_name                    = var.docker_image_name
        image_tag                     = local.omd.docker_image_tag
        ingestion_image_name          = var.ingestion_image_name
        initial_admins                = jsonencode(var.initial_admins)
        principal_domain              = var.principal_domain
        workflows_execution_namespace = local.omd.namespace
        image_pull_policy             = "Always"
        image_pull_secrets            = ["omd-registry-credentials"]
        argowf_token                  = kubernetes_secret.om_role_token.metadata[0].name
        argowf_sa                     = kubernetes_service_account_v1.om_role.metadata[0].name
        caip_enabled                  = var.caip_enabled
        caip_embedding_provider       = var.caip_embedding_provider
        caip_aws_bedrock_region       = var.caip_aws_bedrock_region
        caip_host                     = var.caip_host
        db_host                       = module.db_omd.db_instance_address
        db_port                       = module.db_omd.db_instance_port
        db_user                       = module.db_omd.db_instance_username
        db_secret                     = kubernetes_secret.db_credentials.metadata[0].name
        db_secret_key                 = "password"
        es_host                       = aws_opensearch_domain.opensearch.endpoint
        es_port                       = "443"
        es_scheme                     = "https"
        es_username                   = "admin"
        es_secret                     = kubernetes_secret.opensearch_credentials.metadata[0].name
        es_secret_key                 = "master-password"
      }
    )
  ]
}
