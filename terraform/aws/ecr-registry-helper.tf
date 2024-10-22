# Helper to refresh Collate Docker image credentials

resource "kubernetes_cron_job_v1" "ecr_registry_helper" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "ecr-registry-helper"
    namespace = kubernetes_namespace.app.id
  }

  spec {
    schedule                      = "* */6 * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 2
    suspend                       = false

    job_template {
      metadata {
        name = "ecr-registry-helper-job"
      }
      spec {
        template {
          metadata {
            name = "ecr-registry-helper-pod"
          }
          spec {
            service_account_name = kubernetes_service_account_v1.omd_cron_sa[0].metadata[0].name
            container {
              name  = "ecr-registry-helper"
              image = "public.ecr.aws/r2h3l6e4/awscli-kubectl:latest"
              env_from {
                secret_ref {
                  name = kubernetes_secret.ecr_registry_helper[0].metadata[0].name
                }
              }
              env_from {
                config_map_ref {
                  name = kubernetes_config_map.ecr_registry_helper_config[0].metadata[0].name
                }
              }
              command = ["/bin/bash", "-c", <<-EOF
                 ECR_TOKEN="$(aws ecr get-login-password)"
                 kubectl delete secret --ignore-not-found $DOCKER_SECRET_NAME -n $NAMESPACE_NAME
                 kubectl create secret docker-registry $DOCKER_SECRET_NAME --docker-server=https://118146679784.dkr.ecr.eu-west-1.amazonaws.com --docker-username=AWS --docker-password=$ECR_TOKEN --namespace=$NAMESPACE_NAME
                 echo "Secret was successfully updated at $(date)"
               EOF
              ]
            }

            restart_policy = "Never"
          }
        }
      }
    }
  }
}


# Configuration assets

resource "kubernetes_secret" "ecr_registry_helper" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "omd-ecr-credentials"
    namespace = kubernetes_namespace.app.id
  }
  data = {
    AWS_SECRET_ACCESS_KEY = var.ECR_SECRET_KEY
    AWS_ACCESS_KEY_ID     = var.ECR_ACCESS_KEY
    AWS_ACCOUNT           = "118146679784"
  }
}

resource "kubernetes_config_map" "ecr_registry_helper_config" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "omd-pull-secret-refresh"
    namespace = kubernetes_namespace.app.id
  }

  data = {
    AWS_REGION         = "eu-west-1"
    DOCKER_SECRET_NAME = "omd-registry-credentials"
    NAMESPACE_NAME     = kubernetes_namespace.app.id
  }
}


# Roles and role binding
# Grants the CronJob permission to delete and create secrets in the desired namespace.

resource "kubernetes_service_account_v1" "omd_cron_sa" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "omd-pull-secret-refresh"
    namespace = kubernetes_namespace.app.id
  }
  depends_on = [kubernetes_namespace.app]
}

resource "kubernetes_role" "secrets" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "access-to-secrets"
    namespace = kubernetes_namespace.app.id
  }

  rule {
    verbs      = ["create", "delete"]
    api_groups = [""]
    resources  = ["secrets"]
  }
}

resource "kubernetes_role_binding" "cron" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "omd-pull-secret-refresh"
    namespace = kubernetes_namespace.app.id
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.secrets[0].metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.omd_cron_sa[0].metadata[0].name
    namespace = kubernetes_namespace.app.id
  }
}
