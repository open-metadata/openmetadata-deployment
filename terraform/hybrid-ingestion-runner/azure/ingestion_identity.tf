locals {
  ingestion_sa_name = "ingestion"
}

resource "azuread_application" "ingestion" {
  display_name = "${local.ingestion_sa_name}-${var.environment}"
}

resource "azuread_service_principal" "ingestion" {
  application_id = azuread_application.ingestion.application_id
}

resource "azuread_federated_identity_credential" "ingestion" {
  name                  = "${azuread_application.ingestion.display_name}-federated-identity"
  application_object_id = azuread_application.ingestion.object_id
  issuer                = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject               = "system:serviceaccount:${local.namespace}:${local.ingestion_sa_name}"
  audiences             = ["api://AzureADTokenExchange"]
}

resource "kubernetes_service_account" "ingestion" {
  metadata {
    name      = local.ingestion_sa_name
    namespace = local.namespace
    annotations = {
      "azure.workload.identity/client-id" = azuread_service_principal.ingestion.app_id
    }
  }
  depends_on = [azuread_federated_identity_credential.ingestion]
}