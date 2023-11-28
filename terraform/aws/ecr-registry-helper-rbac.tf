##
## grants the CronJob permission to delete and create secrets in the desired namespace.
##

resource "kubernetes_service_account_v1" "om_argo_cron_sa" {
  metadata {
    name = "om-argo-cron-sa"

    namespace = kubernetes_namespace.argowf.id

  }

  depends_on = [kubernetes_namespace.argowf]
}

resource "kubernetes_role" "cron-role" {
  metadata {
    name      = "cron-role-full-access-to-secrets"
    namespace = kubernetes_namespace.argowf.id
  }

  rule {
    verbs          = ["create", "delete"]
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["regcred"]
  }

}

resource "kubernetes_role_binding" "cron_role_binding" {
  metadata {
    name      = "cron_role_binding"
    namespace = kubernetes_namespace.argowf.id
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.cron-role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.ecr_registry_helper_k8s_service_account.metadata[0].name
    namespace = kubernetes_namespace.argowf.id
  }
}
