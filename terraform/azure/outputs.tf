output "azurerm_storage_account_name" {
  value = azurerm_storage_account.argo_workflows_azure_artifact.name
}

output "azurerm_storage_account_container_name" {
  value = azurerm_storage_container.artifact.name
}

output "argo_workflows_azurerm_user_identity_client_id" {
  value = azurerm_user_assigned_identity.argo_workflows.client_id
}

output "argo_workflows_azurerm_user_identity_object_id" {
  value = azurerm_user_assigned_identity.argo_workflows.principal_id
}

output "argo_workflows_server_azurerm_user_identity_client_id" {
  value = azurerm_user_assigned_identity.argo_workflows_server_pod.client_id
}

output "argo_workflows_server_azurerm_user_identity_object_id" {
  value = azurerm_user_assigned_identity.argo_workflows_server_pod.principal_id
}

output "argo_workflows_controller_azurerm_user_identity_client_id" {
  value = azurerm_user_assigned_identity.argo_workflows_controller_pod.client_id
}

output "argo_workflows_controller_azurerm_user_identity_object_id" {
  value = azurerm_user_assigned_identity.argo_workflows_controller_pod.principal_id
}