resource "azurerm_user_assigned_identity" "argowf_server" {
  name                = "${local.argowf.server_sa_name}-${var.environment}"
  resource_group_name = var.aks_resource_group_name
  location            = var.location
}

resource "azurerm_user_assigned_identity" "argowf_controller" {
  name                = "${local.argowf.controller_sa_name}-${var.environment}"
  resource_group_name = var.aks_resource_group_name
  location            = var.location
}

resource "azurerm_federated_identity_credential" "argowf_server" {
  name                = "${local.argowf.server_sa_name}-${var.environment}-fic"
  resource_group_name = var.aks_resource_group_name
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject             = "system:serviceaccount:${local.namespace}:${local.argowf.server_sa_name}"
  parent_id           = azurerm_user_assigned_identity.argowf_server.id
  audience            = ["api://AzureADTokenExchange"]
}

resource "azurerm_federated_identity_credential" "argowf_controller" {
  name                = "${local.argowf.controller_sa_name}-${var.environment}-fic"
  resource_group_name = var.aks_resource_group_name
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject             = "system:serviceaccount:${local.namespace}:${local.argowf.controller_sa_name}"
  parent_id           = azurerm_user_assigned_identity.argowf_controller.id
  audience            = ["api://AzureADTokenExchange"]
}

# Assign Azure Storage Blob Data Reader role to the Argo Workflow Server user-assigned identities
resource "azurerm_role_assignment" "argowf_server_storage_blob_data_reader" {
  scope                = azurerm_storage_account.argowf.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.argowf_server.principal_id
  principal_type       = "ServicePrincipal"
  depends_on           = [azurerm_user_assigned_identity.argowf_server]
}

# Assign Azure Storage Blob Data Contributor role to the Argo Workflow Controller user-assigned identities
resource "azurerm_role_assignment" "argowf_controller_storage_blob_data_contributor" {
  scope                = azurerm_storage_account.argowf.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.argowf_controller.principal_id
  principal_type       = "ServicePrincipal"
  depends_on           = [azurerm_user_assigned_identity.argowf_controller]
}
