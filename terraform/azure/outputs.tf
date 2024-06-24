output "azurerm_storage_account" {
  value = azurerm_storage_account.argo_workflows_azure_artifact.name
}

output "argo_workflows_azurerm_user_identity_client_id" {
  value = azurerm_user_assigned_identity.argo_workflows.client_id
}

output "argo_workflows_azurerm_user_identity_object_id" {
  value = azurerm_user_assigned_identity.argo_workflows.principal_id
}