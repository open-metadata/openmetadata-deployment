resource "azurerm_storage_account" "argo_workflows_azure_artifact" {
  resource_group_name             = var.resource_group_name
  name                            = var.argo_azure_artifact_name
  location                        = var.azure_location
  account_tier                    = "Standard"
  account_replication_type        = "RAGRS"
  allow_nested_items_to_be_public = false
  blob_properties {
    delete_retention_policy {
      days = 30 # This can be useful to save extra cost and to automatically delete any personal data after processing
    }
  }
}

resource "azurerm_storage_container" "artifact" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.argo_workflows_azure_artifact.name
  container_access_type = "private"
}