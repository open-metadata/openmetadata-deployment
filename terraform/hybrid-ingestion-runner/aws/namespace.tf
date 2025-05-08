resource "kubernetes_namespace" "hybrid_runner" {
  metadata {
    name = local.namespace
  }
}
