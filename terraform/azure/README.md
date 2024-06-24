<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.109.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.109.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.argo_workflows](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.argo_workflows_controller_pod](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.argo_workflows_server_pod](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/federated_identity_credential) | resource |
| [azurerm_role_assignment.blob_storage_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_storage_read_access_for_controller_pod](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_storage_read_access_for_server_pod](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.argo_workflows_azure_artifact](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.artifact](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.argo_workflows](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.argo_workflows_controller_pod](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.argo_workflows_server_pod](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/3.109.0/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_name"></a> [aks\_name](#input\_aks\_name) | n/a | `string` | n/a | yes |
| <a name="input_application_namespace"></a> [application\_namespace](#input\_application\_namespace) | The Namespace in AKS where Collate will spin up Argo Workflows for Ingestion. | `string` | n/a | yes |
| <a name="input_argo_azure_artifact_name"></a> [argo\_azure\_artifact\_name](#input\_argo\_azure\_artifact\_name) | Name of Azure Storage Account to be used for Argo Workflows. | `string` | n/a | yes |
| <a name="input_argo_controller_service_account_name"></a> [argo\_controller\_service\_account\_name](#input\_argo\_controller\_service\_account\_name) | Service Account Name for Argo Workflows Controller Pod. | `string` | n/a | yes |
| <a name="input_argo_namespace"></a> [argo\_namespace](#input\_argo\_namespace) | The Namespace in AKS where ArgoWorkflows are installed. | `string` | n/a | yes |
| <a name="input_argo_server_service_account_name"></a> [argo\_server\_service\_account\_name](#input\_argo\_server\_service\_account\_name) | Service Account Name for Argo Workflows Server Pod. | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | n/a | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the Azure Storage Container within the Storage Account. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Name of Azure Resource Group for Storage Account and AKS. | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The Service Account Name that will be used by Collate Ingestion. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Subscription Id for the Azure Account. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argo_workflows_azurerm_user_identity_client_id"></a> [argo\_workflows\_azurerm\_user\_identity\_client\_id](#output\_argo\_workflows\_azurerm\_user\_identity\_client\_id) | n/a |
| <a name="output_argo_workflows_azurerm_user_identity_object_id"></a> [argo\_workflows\_azurerm\_user\_identity\_object\_id](#output\_argo\_workflows\_azurerm\_user\_identity\_object\_id) | n/a |
| <a name="output_argo_workflows_controller_azurerm_user_identity_client_id"></a> [argo\_workflows\_controller\_azurerm\_user\_identity\_client\_id](#output\_argo\_workflows\_controller\_azurerm\_user\_identity\_client\_id) | n/a |
| <a name="output_argo_workflows_controller_azurerm_user_identity_object_id"></a> [argo\_workflows\_controller\_azurerm\_user\_identity\_object\_id](#output\_argo\_workflows\_controller\_azurerm\_user\_identity\_object\_id) | n/a |
| <a name="output_argo_workflows_server_azurerm_user_identity_client_id"></a> [argo\_workflows\_server\_azurerm\_user\_identity\_client\_id](#output\_argo\_workflows\_server\_azurerm\_user\_identity\_client\_id) | n/a |
| <a name="output_argo_workflows_server_azurerm_user_identity_object_id"></a> [argo\_workflows\_server\_azurerm\_user\_identity\_object\_id](#output\_argo\_workflows\_server\_azurerm\_user\_identity\_object\_id) | n/a |
| <a name="output_azurerm_storage_account_container_name"></a> [azurerm\_storage\_account\_container\_name](#output\_azurerm\_storage\_account\_container\_name) | n/a |
| <a name="output_azurerm_storage_account_name"></a> [azurerm\_storage\_account\_name](#output\_azurerm\_storage\_account\_name) | n/a |
<!-- END_TF_DOCS -->