resource "azurerm_role_assignment" "blob_storage_access" {
  for_each             = azurerm_storage_container.artifact
  scope                = each.value.resource_manager_id
  principal_id         = azurerm_user_assigned_identity.argo_workflows.principal_id # The principal ID of the managed workload identity that will access to the Azure Storage Container.
  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "blob_storage_read_access_for_server_pod" {
  for_each             = azurerm_storage_container.artifact
  scope                = each.value.resource_manager_id
  principal_id         = azurerm_user_assigned_identity.argo_workflows_server_pod.principal_id
  role_definition_name = "Storage Blob Data Reader"
}

resource "azurerm_role_assignment" "blob_storage_read_access_for_controller_pod" {
  for_each             = azurerm_storage_container.artifact
  scope                = each.value.resource_manager_id
  principal_id         = azurerm_user_assigned_identity.argo_workflows_controller_pod.principal_id
  role_definition_name = "Storage Blob Data Reader"
}