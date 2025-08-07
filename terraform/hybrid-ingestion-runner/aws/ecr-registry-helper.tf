# Helper to refresh Collate Docker image credentials

locals {
  docker_registry = "https://118146679784.dkr.ecr.eu-west-1.amazonaws.com"
  registry_helper_manifest = yamldecode(
    var.ECR_ACCESS_KEY == null ?
    "{}" :
    <<-EOF
    serviceAccountName : "${kubernetes_service_account_v1.omd_cron_sa[0].metadata[0].name}"
    containers:
      - name: "ecr-registry-helper"
        image: "public.ecr.aws/r2h3l6e4/awscli-kubectl:latest"
        envFrom:
          - secretRef:
              name: "${kubernetes_secret.ecr_registry_helper[0].metadata[0].name}"
          - configMapRef:
              name: "${kubernetes_config_map.ecr_registry_helper_config[0].metadata[0].name}"
        command: ["/bin/bash", "-c"]
        args:
        - ECR_TOKEN="$(aws ecr get-login-password)" &&
          kubectl delete secret --ignore-not-found $DOCKER_SECRET_NAME -n $NAMESPACE_NAME &&
          kubectl create secret docker-registry $DOCKER_SECRET_NAME --docker-server=${local.docker_registry} --docker-username=AWS --docker-password=$ECR_TOKEN --namespace=$NAMESPACE_NAME &&
          echo "Secret was successfully updated at $(date)"
    restartPolicy: "Never"
    EOF
  )
}

resource "kubernetes_manifest" "ecr_registry_helper_cronjob" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  manifest = {
    apiVersion = "batch/v1"
    kind       = "CronJob"
    metadata = {
      name      = "ecr-registry-helper"
      namespace = kubernetes_namespace.hybrid_runner.id
    }
    spec = {
      schedule                   = "0 */6 * * *"
      startingDeadlineSeconds    = 10
      successfulJobsHistoryLimit = 2
      failedJobsHistoryLimit     = 2
      suspend                    = false
      jobTemplate = {
        spec = {
          template = {
            spec = local.registry_helper_manifest
          }
        }
      }
    }
  }
}

# Job to run the helper immediately after deployment
resource "kubernetes_manifest" "ecr_registry_helper_one_shot" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  manifest = {
    apiVersion = "batch/v1"
    kind       = "Job"
    metadata = {
      name      = "ecr-registry-helper-one-shot"
      namespace = kubernetes_namespace.hybrid_runner.id
    }
    spec = {
      template = {
        spec = local.registry_helper_manifest
      }
    }
  }
}

# Configuration assets

resource "kubernetes_secret" "ecr_registry_helper" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "aws-credentials"
    namespace = kubernetes_namespace.hybrid_runner.id
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
    namespace = kubernetes_namespace.hybrid_runner.id
  }

  data = {
    AWS_REGION         = "eu-west-1"
    DOCKER_SECRET_NAME = "omd-registry-credentials"
    NAMESPACE_NAME     = kubernetes_namespace.hybrid_runner.id
  }
}


# Roles and role binding
# Grants the CronJob permission to delete and create secrets in the desired namespace.

resource "kubernetes_service_account_v1" "omd_cron_sa" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "omd-pull-secret-refresh"
    namespace = kubernetes_namespace.hybrid_runner.id
  }
  depends_on = [kubernetes_namespace.hybrid_runner]
}

resource "kubernetes_role" "secrets" {
  count = var.ECR_ACCESS_KEY != null ? 1 : 0
  metadata {
    name      = "access-to-secrets"
    namespace = kubernetes_namespace.hybrid_runner.id
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
    namespace = kubernetes_namespace.hybrid_runner.id
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.secrets[0].metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.omd_cron_sa[0].metadata[0].name
    namespace = kubernetes_namespace.hybrid_runner.id
  }
}
