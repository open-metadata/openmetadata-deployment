locals {
  caip = {
    "region"                   = var.region
    "collate.hostAndPort"      = "http://openmetadata:8585"
    "imagePullSecrets[0].name" = "omd-registry-credentials"
  }
}

resource "helm_release" "caip" {
  count      = var.caip_enabled ? 1 : 0
  name       = "caip"
  repository = "https://open-metadata.github.io/collate-ai-proxy-helm-chart"
  chart      = "collate-ai-proxy"
  version    = "0.0.1"
  #version    = local.omd.helm_chart_version
  namespace = kubernetes_namespace.app.id
  wait      = false
  set = [for key, value in merge(local.caip, var.caip_helm_values) :
    {
      "name"  = key
      "value" = value
    }
  ]

  #  set_list = [
  #    {
  #      name  = "imagePullSecrets"
  #      value = [{ "name": "omd-registry-credentials"}]
  #    }
  #  ]
}
