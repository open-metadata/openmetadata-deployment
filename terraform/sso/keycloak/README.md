## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 4.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [keycloak_openid_client.openid_client](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_client) | resource |
| [keycloak_realm.omd_realm](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/realm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keycloak_url"></a> [keycloak\_url](#input\_keycloak\_url) | The URL of the Keycloak instance | `string` | `"http://localhost:8080"` | yes |
| <a name="input_openid_client_id"></a> [openid\_client\_id](#input\_openid\_client\_id) | The Client ID for this client, referenced in the URI during authentication and in issued tokens | `string` | `"open-metadata"` | yes |
| <a name="input_post_logout_redirect_uris"></a> [post\_logout\_redirect\_uris](#input\_post\_logout\_redirect\_uris) | A list of valid URIs a browser is permitted to redirect to after a successful logout | `list(string)` | <pre>[<br>  "http://localhost:8585"<br>]</pre> | no |
| <a name="input_realm"></a> [realm](#input\_realm) | The name of the realm | `string` | `"omd-realm"` | yes |
| <a name="input_realm_display_name"></a> [realm\_display\_name](#input\_realm\_display\_name) | The display name for the realm that is shown when logging in to the admin console | `string` | `"OMD Realm"` | no |
| <a name="input_redirect_uris"></a> [redirect\_uris](#input\_redirect\_uris) | A list of valid URIs a browser is permitted to redirect to after a successful login | `list(string)` | <pre>[<br>  "http://localhost:8585",<br>  "http://localhost:8585/callback"<br>]</pre> | no |
| <a name="input_web_origins"></a> [web\_origins](#input\_web\_origins) | A list of allowed CORS origins | `list(string)` | <pre>[<br>  "http://localhost:8585"<br>]</pre> | no |

## Outputs

No outputs.