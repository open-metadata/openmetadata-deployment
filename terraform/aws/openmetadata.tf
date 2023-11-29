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
# # ecr registry creds
# resource "kubernetes_secret" "ecr_registry_creds" {
#   metadata {
#     name      = "ecr-registry-creds"
#     namespace = kubernetes_namespace.argowf.id
#   }

#   data = {
#     ".dockerconfigjson" = jsonencode(
#       {
#         auths = {
#           "118146679784.dkr.ecr.eu-west-1.amazonaws.com" = {
#             "username" = "AWS"
#             "password" = "${var.ecr_auth_token}"
#           }
#         }
#       }
#     )
#   }

#   type = "kubernetes.io/dockerconfigjson"
# }

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
  # depends_on = [kubernetes_secret.ecr_registry_creds]
}