## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 4.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_app_oauth.app_omd](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth) | resource |
| [okta_auth_server.server_omd](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server) | resource |
| [okta_auth_server_policy.policy_omd_server](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy) | resource |
| [okta_auth_server_policy_rule.rule_omd_server_policy](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy_rule) | resource |
| [okta_auth_server_scope.scope_omd_server](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_scope) | resource |
| [okta_trusted_origin.to_omd](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/trusted_origin) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_server_client_whitelist"></a> [auth\_server\_client\_whitelist](#input\_auth\_server\_client\_whitelist) | The clients to whitelist the policy for | `list(string)` | <pre>[<br>  "ALL_CLIENTS"<br>]</pre> | yes |
| <a name="input_auth_server_name"></a> [auth\_server\_name](#input\_auth\_server\_name) | Authorizer Server Name | `string` | `"Openmetadata Server"` | yes |
| <a name="input_auth_server_policy_grant_type"></a> [auth\_server\_policy\_grant\_type](#input\_auth\_server\_policy\_grant\_type) | List of accepted grant type values for the policy rule | `list(string)` | <pre>[<br>  "client_credentials",<br>  "authorization_code",<br>  "urn:ietf:params:oauth:grant-type:token-exchange",<br>  "urn:ietf:params:oauth:grant-type:device_code"<br>]</pre> | yes |
| <a name="input_auth_server_policy_groups"></a> [auth\_server\_policy\_groups](#input\_auth\_server\_policy\_groups) | Specifies a set of Groups whose Users are to be included for the policy rule | `list(string)` | <pre>[<br>  "EVERYONE"<br>]</pre> | no |
| <a name="input_auth_server_policy_name"></a> [auth\_server\_policy\_name](#input\_auth\_server\_policy\_name) | Name for policy created for Authorizer server | `string` | `"OMD_Server_Policy"` | yes |
| <a name="input_auth_server_policy_rule"></a> [auth\_server\_policy\_rule](#input\_auth\_server\_policy\_rule) | Name of the Authorization Server Policy Rule | `string` | `"OMD Server Policy Rule"` | yes |
| <a name="input_auth_server_policy_scope"></a> [auth\_server\_policy\_scope](#input\_auth\_server\_policy\_scope) | List of Scopes allowed for the policy rule | `list(string)` | <pre>[<br>  "*"<br>]</pre> | yes |
| <a name="input_auth_server_scope_name"></a> [auth\_server\_scope\_name](#input\_auth\_server\_scope\_name) | Scope for Authorizer server | `string` | `"Scope_for_OMD_server"` | yes |
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | Base URL of Okta | `string` | `"okta.com"` | no |
| <a name="input_logout_redirect_uris"></a> [logout\_redirect\_uris](#input\_logout\_redirect\_uris) | List of URIs for redirection after logout | `list(string)` | <pre>[<br>  "http://localhost:8585"<br>]</pre> | no |
| <a name="input_oauth_app_grant_types"></a> [oauth\_app\_grant\_types](#input\_oauth\_app\_grant\_types) | List of OAuth 2.0 grant types for OIDC app | `list(string)` | <pre>[<br>  "authorization_code",<br>  "refresh_token",<br>  "implicit"<br>]</pre> | no |
| <a name="input_oauth_app_label"></a> [oauth\_app\_label](#input\_oauth\_app\_label) | Label of the OIDC app | `string` | `"App-Openmetadata"` | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Organization name for Okta | `string` | `"trial-6795048"` | no |
| <a name="input_redirect_uris"></a> [redirect\_uris](#input\_redirect\_uris) | List of URIs for use in the redirect-based flow | `list(string)` | <pre>[<br>  "http://localhost:8585/callback",<br>  "http://localhost:8585/silent-callback"<br>]</pre> | no |
| <a name="input_trusted_origin_name"></a> [trusted\_origin\_name](#input\_trusted\_origin\_name) | Name of the Trusted Origin | `string` | `"Openmetadata Trusted Origin"` | yes |
| <a name="input_trusted_origin_url"></a> [trusted\_origin\_url](#input\_trusted\_origin\_url) | URL of the Trusted Origin | `string` | `"http://localhost:8585"` | yes |

## Outputs

No outputs.