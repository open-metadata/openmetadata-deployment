## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.omd_user_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.userpool_client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.omd_user_pool_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_callback_urls"></a> [client\_callback\_urls](#input\_client\_callback\_urls) | List of allowed callback URLs for the identity provider | `list(string)` | <pre>[<br>  "http://localhost:8585/callback"<br>]</pre> | no |
| <a name="input_from_email_address"></a> [from\_email\_address](#input\_from\_email\_address) | Sender's email address or sender's display name with their email address | `string` | `"no-reply@verificationemail.com"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for AWS Cognito User Pool | `string` | `"us-east-1"` | no |
| <a name="input_user_pool_alias_attributes"></a> [user\_pool\_alias\_attributes](#input\_user\_pool\_alias\_attributes) | Attributes supported as an alias for the user pool | `list(string)` | <pre>[<br>  "email"<br>]</pre> | no |
| <a name="input_user_pool_client_name"></a> [user\_pool\_client\_name](#input\_user\_pool\_client\_name) | Name of the application client | `string` | `"app-OMD"` | yes |
| <a name="input_user_pool_domain"></a> [user\_pool\_domain](#input\_user\_pool\_domain) | Domain for user pool | `string` | `"openmetadata"` | yes |
| <a name="input_user_pool_name"></a> [user\_pool\_name](#input\_user\_pool\_name) | Name for the Cognito user pool | `string` | `"OMD Pool"` | yes |

## Outputs

No outputs.