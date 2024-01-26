##
## Locals
##

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

##
## Namespace
##

resource "kubernetes_namespace" "app" {
  metadata {
    annotations = {
      name = local.omd.namespace
    }
    name = local.omd.namespace
  }
}

##
## Database credentials secret
##
resource "kubernetes_secret" "db_credentials" {
  metadata {
    name      = "db-secrets"
    namespace = kubernetes_namespace.app.id
  }

  data = {
    openmetadata-mysql-password = base64encode(random_password.db_password.result)
  }
}

##
## Application Helm release
##
resource "helm_release" "openmetadata" {
  name       = "openmetadata"
  repository = "https://helm.open-metadata.org"
  chart      = "openmetadata"
  version    = "1.2.5"
  namespace  = kubernetes_namespace.app.id
  values = [
    templatefile("${path.module}/helm-dependencies/openmetadata_config.tftpl",
      {
        namespace            = var.app_namespace
        image_name           = var.docker_image_name
        image_tag            = var.docker_image_tag
        ingestion_image_name = var.ingestion_image_name
        argowf_namespace     = kubernetes_namespace.argowf.id
        image_pull_policy    = "always"
        image_pull_secrets   = ["omd-registry-credentials"]
        argowf_token         = "TODO" # To define
        argowf_sa            = kubernetes_service_account_v1.om_argo_sa.metadata[0].name
        db_host              = module.db_omd.db_instance_address
        db_port              = module.db_omd.db_instance_port
        db_user              = module.db_omd.db_instance_username
    })
  ]
}
