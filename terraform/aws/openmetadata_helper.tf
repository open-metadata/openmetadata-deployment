# Service Account

resource "kubernetes_service_account_v1" "om_role" {
  metadata {
    name      = "om-role"
    namespace = kubernetes_namespace.app.id
    annotations = {
      "eks.amazonaws.com/role-arn" = module.irsa_role_argowf_jobs.iam_role_arn
    }
  }
}


# OpenMetadata role

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


# OpenMetadata role binding

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
    name      = kubernetes_service_account_v1.om_role.metadata[0].name
    namespace = kubernetes_namespace.app.id
  }
}


# OpenMetadata secret

resource "kubernetes_secret" "om_role_token" {
  metadata {
    name      = "om-role.service-account-token"
    namespace = kubernetes_namespace.app.id
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account_v1.om_role.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}
