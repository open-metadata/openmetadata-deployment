##
## Service Account
##

resource "kubernetes_service_account_v1" "om_argo_sa" {
  metadata {
    name      = "om-argo-wf-sa"
    namespace = kubernetes_namespace.app.id

  }
}

# OM Role
resource "kubernetes_role" "om-argo-role" {
  metadata {
    name      = "om-argo-role"
    namespace = kubernetes_namespace.app.id
  }

  rule {
    verbs      = ["list", "watch", "create", "update", "patch", "get", "delete"]
    api_groups = ["argoproj.io"]
    resources  = ["workflows"]
  }

  rule {
    verbs      = ["list", "watch", "patch", "get"]
    api_groups = [""]
    resources  = ["pods/log", "pods"]
  }

  rule {
    verbs      = ["list", "watch", "create", "update", "patch", "get", "delete"]
    api_groups = ["argoproj.io"]
    resources  = ["cronworkflows"]
  }

  rule {
    verbs      = ["create", "patch"]
    api_groups = ["argoproj.io"]
    resources  = ["workflowtaskresults"]
  }
}

# OM role binding
resource "kubernetes_role_binding" "om-argo-role-binding" {
  metadata {
    name      = "om-argo-role-binding"
    namespace = kubernetes_namespace.app.id
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.om-argo-role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.om_argo_sa.metadata[0].name
    namespace = kubernetes_namespace.app.id
  }
}

# OM secret
resource "kubernetes_secret" "om_role_token" {
  metadata {
    name      = "om-argo-wf-sa.service-account-token"
    namespace = kubernetes_namespace.app.id
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account_v1.om_argo_sa.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}
