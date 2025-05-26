provider "azurerm" {
  features        = {}
  subscription_id = var.subscription_id
}

provider "azuread" {
  tenant_id = var.tenant_id
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "az"
    args        = ["aks", "get-token", "--resource-group", var.aks_resource_group_name, "--name", var.aks_cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "az"
      args        = ["aks", "get-token", "--resource-group", var.aks_resource_group_name, "--name", var.aks_cluster_name]
    }
  }
}