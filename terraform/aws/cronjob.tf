resource "kubernetes_cron_job_v1" "ecr_registry_helper" {
  metadata {
    name      = "ecr-registry-helper"
    namespace = kubernetes_namespace.argowf.id
  }

  spec {
    schedule                      = "* */10 * * *"
    successful_jobs_history_limit = 2
    suspend                       = false

    job_template {
      metadata {
        name = "ecr-registry-helper-job"
      }
      spec {
        template {
          metadata { # Add a metadata block inside template
            name = "ecr-registry-helper-pod"
          }
          spec {
            service_account_name = kubernetes_service_account_v1.om_argo_cron_sa.metadata[0].name
            container {
              name  = "ecr-registry-helper"
              image = "public.ecr.aws/r2h3l6e4/awscli-kubectl:latest"
              env_from {
                secret_ref {
                  name = kubernetes_secret.ecr_registry_helper_k8s_secret.metadata[0].name
                }
              }
              env_from {
                config_map_ref {
                  name = kubernetes_config_map.ecr_registry_helper_k8s_config_map.metadata[0].name
                }
              }
              env {
                name  = "DOCKER_SECRET_NAME"
                value = kubernetes_config_map.ecr_registry_helper_k8s_config_map.data["DOCKER_SECRET_NAME"]
              }
              env {
                name  = "NAMESPACE_NAME"
                value = kubernetes_namespace.argowf.id
              }
              command = ["/bin/bash", "-c", <<-EOF
                 ECR_TOKEN="$(aws ecr get-login-password --region eu-west-1)"
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