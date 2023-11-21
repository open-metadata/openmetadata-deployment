##
## Locals
##

locals {
  argo = {
    # iam_role_name  = "${var.name}-argo-secrets"
    namespace = "argowf"
    # eso_sa_name    = "argocd-eso"
    # manifests_repo = "https://github.com/open-metadata/k8s-manifests.git"
  }
}

##
## Namespace
##

resource "kubernetes_namespace" "argocd" {
  metadata {
    annotations = {
      name = local.argo.namespace
    }

    labels = {
      cost-center = "devops"
    }

    name = local.argo.namespace
  }
}

##
## Helm chart argowf
##
resource "helm_release" "argowf" {
  name       = "argowf"
  namespace  = local.argo.namespace
  chart      = "argo-workflows"
  version    = "0.32.2"
  repository = "https://argoproj.github.io/argo-helm"
  values = [
    file("argo-workflows.values.yml"),
  ]
}
