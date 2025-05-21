# IAM identities for Argo Workflows (workload identity)

resource "azuread_application" "argowf_server" {
  display_name = "${local.argowf.server_sa_name}-${var.environment}"
}

resource "azuread_service_principal" "argowf_server" {
  application_id = azuread_application.argowf_server.application_id
}

resource "azuread_federated_identity_credential" "argowf_server" {
  name                  = "${azuread_application.argowf_server.display_name}-federated-identity"
  application_object_id = azuread_application.argowf_server.object_id
  issuer                = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject               = "system:serviceaccount:${local.argowf.namespace}:${local.argowf.server_sa_name}"
  audiences             = ["api://AzureADTokenExchange"]
}

resource "kubernetes_service_account" "argowf_server" {
  metadata {
    name      = local.argowf.server_sa_name
    namespace = local.argowf.namespace
    annotations = {
      "azure.workload.identity/client-id" = azuread_service_principal.argowf_server.app_id
    }
  }
  depends_on = [azuread_federated_identity_credential.argowf_server]
}

resource "azuread_application" "argowf_controller" {
  display_name = "${local.argowf.controller_sa_name}-${var.environment}"
}

resource "azuread_service_principal" "argowf_controller" {
  application_id = azuread_application.argowf_controller.application_id
}

resource "azuread_federated_identity_credential" "argowf_controller" {
  name                  = "${azuread_application.argowf_controller.display_name}-federated-identity"
  application_object_id = azuread_application.argowf_controller.object_id
  issuer                = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject               = "system:serviceaccount:${local.argowf.namespace}:${local.argowf.controller_sa_name}"
  audiences             = ["api://AzureADTokenExchange"]
}

resource "kubernetes_service_account" "argowf_controller" {
  metadata {
    name      = local.argowf.controller_sa_name
    namespace = local.argowf.namespace
    annotations = {
      "azure.workload.identity/client-id" = azuread_service_principal.argowf_controller.app_id
    }
  }
  depends_on = [azuread_federated_identity_credential.argowf_controller]
}