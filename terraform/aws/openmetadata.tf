locals {
  className                   = "io.collate.pipeline.argo.ArgoServiceClient"
  apiEndpoint                 = "http://argowf-argo-workflows-server:2746"
  metadataApiEndpoint         = "http://openmetadata:8585/api"
  imageRepository             = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-eu-west-1"
  imagePullPolicy             = "IfNotPresent"
  argoServiceAccountTokenName = "om-argo-wf-sa.service-account-token"
}

# random_password generator
resource "random_password" "mysql_password" {
  length      = 16
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}
# mysql secrets
resource "kubernetes_secret" "mysql_secrets" {
  metadata {
    name      = "mysql-secrets"
    namespace = kubernetes_namespace.argowf.id
  }

  data = {
    openmetadata-mysql-password = base64encode(random_password.mysql_password.result)
  }
}

# openmetadata helm release
resource "helm_release" "openmetadata" {
  name       = "openmetadata"
  repository = "https://helm.open-metadata.org"
  chart      = "openmetadata"
  version    = "1.2.4"
  namespace  = kubernetes_namespace.argowf.id
  values = [
    templatefile("${path.module}/helm-dependencies/openmetadata_config.tftpl",
      {
        className                              = local.className
        apiEndpoint                            = local.apiEndpoint
        metadataApiEndpoint                    = local.metadataApiEndpoint
        imageRepository                        = local.imageRepository
        imageTag                               = var.imageTag
        imagePullPolicy                        = local.imagePullPolicy
        imagePullSecretName                    = var.DOCKER_SECRET_NAME
        argoNamespace                          = kubernetes_namespace.argowf.id
        argoServiceAccountTokenName            = local.argoServiceAccountTokenName,
        argoIngestionImage                     = var.argoIngestionImage
        argoWorkflowExecutorServiceAccountName = kubernetes_service_account_v1.om_argo_sa.metadata[0].name
        argoImagePullSecrets                   = var.DOCKER_SECRET_NAME

    })
  ]
  depends_on = [kubernetes_cron_job_v1.ecr_registry_helper]
}