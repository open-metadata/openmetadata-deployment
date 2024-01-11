resource "okta_auth_server" "server_omd" {
  audiences   = ["${okta_app_oauth.app_omd.client_id}"]
  description = "Authorizer for Opemetadata Application"
  name        = var.auth_server_name
  issuer_mode = "ORG_URL"
  status      = "ACTIVE"
}

resource "okta_auth_server_scope" "scope_omd_server" {
  auth_server_id   = okta_auth_server.server_omd.id
  name             = var.auth_server_scope_name
  default          = true
  depends_on       = [okta_auth_server.server_omd]
  consent          = "IMPLICIT"
}

resource "okta_auth_server_policy" "policy_omd_server" {
  auth_server_id   = okta_auth_server.server_omd.id
  status           = "ACTIVE"
  name             = var.auth_server_policy_name
  description      = "Authorizer Server  policy for Openmetadata Server"
  priority         = 1
  client_whitelist = var.auth_server_client_whitelist
}

resource "okta_auth_server_policy_rule" "rule_omd_server_policy" {
  auth_server_id       = okta_auth_server.server_omd.id
  policy_id            = okta_auth_server_policy.policy_omd_server.id
  status               = "ACTIVE"
  name                 = var.auth_server_policy_rule
  priority             = 1
  grant_type_whitelist = var.auth_server_policy_grant_type
  scope_whitelist      = var.auth_server_policy_scope
  group_whitelist      = var.auth_server_policy_groups
}