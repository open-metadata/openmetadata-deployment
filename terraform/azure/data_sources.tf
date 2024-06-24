data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.resource_group_name
}