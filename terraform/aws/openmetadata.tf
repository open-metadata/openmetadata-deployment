resource "kubernetes_secret" "mysql_secrets" {
  metadata {
    name      = "mysql-secrets"
    namespace = kubernetes_namespace.argocd.id
  }

  data = {
    openmetadata-mysql-password = "openmetadata_password"
  }
}
resource "kubernetes_secret" "ecr_registry_creds" {
  metadata {
    name      = "ecr-registry-creds"
    namespace = kubernetes_namespace.argocd.id
  }

  data = {
    ".dockerconfigjson" = base64encode(
      <<-EOT
        {
          "auths": {
            "118146679784.dkr.ecr.eu-west-1.amazonaws.com": {
              "username": "AWS",
              "password": file("${local.docker_password_file_path}")
            }
          }
        }
      EOT
    )
  }

  type = "kubernetes.io/dockerconfigjson"
}
resource "helm_release" "openmetadata" {
  name       = "openmetadata"
  repository = "https://helm.open-metadata.org"
  chart      = "openmetadata"
  version    = "1.2.0"

  namespace  = kubernetes_namespace.argocd.id
  values = [
    file("openmetadata.values.yml")
  ]
  depends_on = [ kubernetes_secret.ecr_registry_creds ]
}