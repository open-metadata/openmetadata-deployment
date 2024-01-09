resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.omd_realm.id
  client_id           = var.openid_client_id
  enabled             = true

  access_type         = "CONFIDENTIAL"

  standard_flow_enabled = true
  implicit_flow_enabled = true
  direct_access_grants_enabled  = true
  service_accounts_enabled  = true

  valid_redirect_uris = var.redirect_uris

  valid_post_logout_redirect_uris = var.post_logout_redirect_uris

  web_origins = var.web_origins
}