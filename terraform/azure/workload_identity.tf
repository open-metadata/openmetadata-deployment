resource "azurerm_user_assigned_identity" "argo_workflows" {
  name                = "${var.application_namespace}-application"
  location            = var.azure_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "argo_workflows_server_pod" {
  name                = "${var.argo_namespace}-server"
  location            = var.azure_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "argo_workflows_controller_pod" {
  name                = "${var.argo_namespace}-controller"
  location            = var.azure_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_federated_identity_credential" "argo_workflows" {
  name                = "${var.application_namespace}-application"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.argo_workflows.id
  subject             = "system:serviceaccount:${var.application_namespace}:${var.application_service_account_name}"
}

resource "azurerm_federated_identity_credential" "argo_workflows_server_pod" {
  name                = "${var.argo_namespace}-server"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.argo_workflows_server_pod.id
  subject             = "system:serviceaccount:${var.argo_namespace}:${var.argo_server_service_account_name}"
}

resource "azurerm_federated_identity_credential" "argo_workflows_controller_pod" {
  name                = "${var.argo_namespace}-controller"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.argo_workflows_controller_pod.id
  subject             = "system:serviceaccount:${var.argo_namespace}:${var.argo_controller_service_account_name}"
}