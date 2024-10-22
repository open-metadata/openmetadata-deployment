locals {
  omd = {
    namespace = var.app_namespace
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
  version    = "1.5.5"
  namespace  = kubernetes_namespace.app.id
  wait       = false
  values = [
    templatefile("${path.module}/helm-dependencies/openmetadata_config.tftpl",
      {
        namespace                     = var.app_namespace
        image_name                    = var.docker_image_name
        image_tag                     = var.docker_image_tag
        ingestion_image_name          = var.ingestion_image_name
        workflows_execution_namespace = var.app_namespace
        image_pull_policy             = "Always"
        image_pull_secrets            = ["omd-registry-credentials"]
        argowf_token                  = kubernetes_secret.om_role_token.metadata[0].name
        argowf_sa                     = kubernetes_service_account_v1.om_role.metadata[0].name
        db_host                       = module.db_omd.db_instance_address
        db_port                       = module.db_omd.db_instance_port
        db_user                       = module.db_omd.db_instance_username
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
