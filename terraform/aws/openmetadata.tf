# mysql secrets
resource "kubernetes_secret" "mysql_secrets" {
  metadata {
    name      = "mysql-secrets"
    namespace = kubernetes_namespace.argowf.id
  }

  data = {
    openmetadata-mysql-password = "openmetadata_password"
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
    file("openmetadata.values.yml")
  ]
  depends_on = [kubernetes_cron_job_v1.ecr_registry_helper]
}