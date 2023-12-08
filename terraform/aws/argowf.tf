##
## Locals
##

locals {
  argo = {
    namespace = "argowf"
  }
  controllerName = "argo-workflows-controller-sa"
  argoSAName     = "argo-workflows-server-sa"
}

##
## Namespace
##

resource "kubernetes_namespace" "argowf" {
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
    templatefile("${path.module}/helm-dependencies/argowf_config.tftpl",
      {
        controllerName = local.controllerName
        argoSAName     = local.argoSAName
    })
  ]
}
