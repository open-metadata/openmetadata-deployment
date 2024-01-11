variable keycloak_url {
    type        = string
    description = "The URL of the Keycloak instance"
    default     = "http://localhost:8080"
}

variable realm {
    type        = string
    description = "The name of the realm"
    default     = "omd-realm"
}

variable realm_display_name {
    type        = string
    description = "The display name for the realm that is shown when logging in to the admin console"
    default     = "OMD Realm"
}

variable openid_client_id {
    type        = string
    description = "The Client ID for this client, referenced in the URI during authentication and in issued tokens"
    default     = "open-metadata"
}

variable redirect_uris {
    type        = list(string)
    description = "A list of valid URIs a browser is permitted to redirect to after a successful login"
    default     = ["http://localhost:8585", "http://localhost:8585/callback"]
}

variable post_logout_redirect_uris {
    type        = list(string)
    description = "A list of valid URIs a browser is permitted to redirect to after a successful logout"
    default     = ["http://localhost:8585"]
}

variable web_origins {
    type        = list(string)
    description = "A list of allowed CORS origins"
    default     = ["http://localhost:8585"]
}