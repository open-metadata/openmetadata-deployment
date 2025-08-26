resource "random_string" "storage_account_suffix" {
  length  = 8
  special = false
}

resource "azurerm_storage_account" "argowf" {
  name                            = local.argowf.storage_account_name
  resource_group_name             = var.aks_resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  blob_properties {
    delete_retention_policy {
      days = 30
    }
  }
}

resource "azurerm_storage_container" "argowf" {
  name                  = local.argowf.storage_container_name
  storage_account_name  = azurerm_storage_account.argowf.name
}