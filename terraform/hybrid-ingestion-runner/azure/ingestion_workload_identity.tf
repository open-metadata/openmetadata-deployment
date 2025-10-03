locals {
  ingestion_sa_name = "ingestion"
}

resource "azurerm_user_assigned_identity" "ingestion" {
  name                = "${local.ingestion_sa_name}-${var.environment}"
  resource_group_name = var.aks_resource_group_name
  location            = var.location
}

resource "azurerm_federated_identity_credential" "ingestion" {
  name                = "${local.ingestion_sa_name}-${var.environment}-fic"
  resource_group_name = var.aks_resource_group_name
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject             = "system:serviceaccount:${local.namespace}:${local.ingestion_sa_name}"
  parent_id           = azurerm_user_assigned_identity.ingestion.id
  audience            = ["api://AzureADTokenExchange"]
}

# Assign Azure Storage Blob Data Contributor role to the ingestion user-assigned identity
resource "azurerm_role_assignment" "ingestion_storage_blob_data_contributor" {
  scope                = azurerm_storage_account.argowf.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.ingestion.principal_id
  principal_type       = "ServicePrincipal"
  depends_on           = [azurerm_user_assigned_identity.ingestion]
}

# Access to Azure Key Vault as Secrets Officer
resource "azurerm_role_assignment" "ingestion_key_vault_secrets_officer" {
  count = var.key_vault_name != null ? 0 : 1
  scope                = data.azurerm_key_vault.key_vault[0].id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.ingestion.principal_id
  principal_type       = "ServicePrincipal"
  depends_on           = [azurerm_user_assigned_identity.ingestion]
}