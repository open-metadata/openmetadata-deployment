data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  resource_group_name = var.aks_resource_group_name
}

data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}