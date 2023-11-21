##
## Service Account
##

resource "kubernetes_service_account_v1" "om_argo_sa" {
  metadata {
    name = "om-argo-wf-sa"

    namespace = kubernetes_namespace.argocd.id

  }

  depends_on = [kubernetes_namespace.argocd]
}

resource "kubernetes_role" "om-argo-role" {
  metadata {
    name = "om-argo-role"
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

resource "kubernetes_role_binding" "om-argo-role-binding" {
  metadata {
    name = "om-argo-role-binding"
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.om-argo-role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "om-argo-wf-sa"
    namespace = kubernetes_namespace.argocd.id
  }
}
resource "kubernetes_secret" "om_role_token" {
  metadata {
    name      = "om-argo-wf-sa.service-account-token"
    namespace = kubernetes_namespace.argocd.id
    annotations = {
      "kubernetes.io/service-account.name" = "om-argo-wf-sa"
    }
  }
  type = "kubernetes.io/service-account-token"
}
resource "helm_release" "openmetadata_dependencies" {
  name      = "openmetadata-dependencies"
  chart     = "open-metadata/openmetadata-dependencies"
  namespace = kubernetes_namespace.argocd.id

  values = [
    file("openmetadata_deps.values.yml"),
  ]
}