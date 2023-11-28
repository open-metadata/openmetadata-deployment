resource "kubernetes_cron_job" "ecr_registry_helper" {
  metadata {
    name      = "ecr-registry-helper"
    namespace = kubernetes_namespace.argowf.id
  }

  spec {
    schedule                      = "0 */10 * * *"
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
            service_account_name = kubernetes_service_account.ecr_registry_helper_k8s_service_account.id
            container {
              name  = "ecr-registry-helper"
              image = "omarxs/awskctl:v1.0"
              env_from {
                secret_ref {
                  name = kubernetes_secret.ecr_registry_helper_k8s_secret.id
                }
              }
              env_from {
                config_map_ref {
                  name = kubernetes_config_map.ecr_registry_helper_k8s_config_map.id
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