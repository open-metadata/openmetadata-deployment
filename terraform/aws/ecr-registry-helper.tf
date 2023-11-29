resource "kubernetes_secret" "ecr_registry_helper_k8s_secret" {
  metadata {
    name      = "ecr-registry-helper-secrets"
    namespace = kubernetes_namespace.argowf.id
  }
  data = {
    AWS_SECRET_ACCESS_KEY = var.SECRET_KEY
    AWS_ACCESS_KEY_ID     = var.ACCESS_KEY
    AWS_ACCOUNT           = "118146679784"
  }
}

resource "kubernetes_config_map" "ecr_registry_helper_k8s_config_map" {
  metadata {
    name      = "ecr-registry-helper-cm"
    namespace = kubernetes_namespace.argowf.id
  }

  data = {
    AWS_REGION         = "eu-west-1"
    DOCKER_SECRET_NAME = "ecr-registry-creds"
  }
}

resource "kubernetes_service_account" "ecr_registry_helper_k8s_service_account" {
  metadata {
    name      = "ecr-auth-sa"
    namespace = kubernetes_namespace.argowf.id
  }
}
