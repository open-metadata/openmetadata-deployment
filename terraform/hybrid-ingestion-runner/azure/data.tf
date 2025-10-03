data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  resource_group_name = var.aks_resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  count               = var.ingestion != null ? 0 : 1
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}