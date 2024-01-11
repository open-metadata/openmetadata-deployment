variable org_name {
    type        = string
    description = "Organization name for Okta"
    default     = "trial-6795048"
}

variable base_url {
    type        = string
    description = "Base URL of Okta"
    default     = "okta.com"
}

variable trusted_origin_name {
    type        = string
    description = "Name of the Trusted Origin"
    default     = "Openmetadata Trusted Origin"
}

variable trusted_origin_url {
    type        = string
    description = "URL of the Trusted Origin"
    default     = "http://localhost:8585"
}

variable oauth_app_label {
    type        = string
    description = "Label of the OIDC app"
    default     = "App-Openmetadata"
}

variable oauth_app_grant_types {
    type        = list(string)
    description = "List of OAuth 2.0 grant types for OIDC app"
    default     = ["authorization_code", "refresh_token", "implicit"]
}

variable redirect_uris {
    type        = list(string)
    description = "List of URIs for use in the redirect-based flow"
    default     = ["http://localhost:8585/callback", "http://localhost:8585/silent-callback"]
}

variable logout_redirect_uris {
    type        = list(string)
    description = "List of URIs for redirection after logout"
    default     = ["http://localhost:8585"]
}

variable auth_server_name {
    type        = string
    description = "Authorizer Server Name"
    default     = "Openmetadata Server"
}

variable auth_server_scope_name {
    type        = string
    description = "Scope for Authorizer server"
    default     = "Scope_for_OMD_server"
}

variable auth_server_policy_name {
    type        = string
    description = "Name for policy created for Authorizer server"
    default     = "OMD_Server_Policy"
}

variable auth_server_client_whitelist {
    type        = list(string)
    description = "The clients to whitelist the policy for"
    default     = ["ALL_CLIENTS"]
}

variable auth_server_policy_rule {
    type        = string
    description = "Name of the Authorization Server Policy Rule"
    default     = "OMD Server Policy Rule"
}

variable auth_server_policy_grant_type {
    type        = list(string)
    description = "List of accepted grant type values for the policy rule"
    default     = ["client_credentials", "authorization_code", "urn:ietf:params:oauth:grant-type:token-exchange", "urn:ietf:params:oauth:grant-type:device_code"]
}

variable auth_server_policy_scope {
    type        = list(string)
    description = "List of Scopes allowed for the policy rule"
    default     = ["*"]
}

variable auth_server_policy_groups {
    type        = list(string)
    description = "Specifies a set of Groups whose Users are to be included for the policy rule"
    default     = ["EVERYONE"]
}