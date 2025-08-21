## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.0)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (~> 2.0)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.0)

## Providers

The following providers are used by this module:

- <a name="provider_azuread"></a> [azuread](#provider\_azuread) (2.53.1)

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (3.117.1)

- <a name="provider_helm"></a> [helm](#provider\_helm) (2.17.0)

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (2.38.0)

- <a name="provider_random"></a> [random](#provider\_random) (3.7.2)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_federated_identity_credential.argowf_controller](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) (resource)
- [azurerm_federated_identity_credential.argowf_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) (resource)
- [azurerm_federated_identity_credential.ingestion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) (resource)
- [azurerm_postgresql_flexible_server.argowf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) (resource)
- [azurerm_postgresql_flexible_server_database.argowf_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) (resource)
- [azurerm_postgresql_flexible_server_firewall_rule.argowf_allow_azure_services](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) (resource)
- [azurerm_role_assignment.argowf_controller_storage_blob_data_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.argowf_server_storage_blob_data_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.ingestion_key_vault_secrets_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.ingestion_storage_blob_data_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_storage_account.argowf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)
- [azurerm_storage_container.argowf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) (resource)
- [azurerm_user_assigned_identity.argowf_controller](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) (resource)
- [azurerm_user_assigned_identity.argowf_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) (resource)
- [azurerm_user_assigned_identity.ingestion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) (resource)
- [helm_release.argowf](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [helm_release.hybrid_runner](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [kubernetes_config_map.ecr_registry_helper_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) (resource)
- [kubernetes_manifest.ecr_registry_helper_cronjob](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) (resource)
- [kubernetes_manifest.ecr_registry_helper_one_shot](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) (resource)
- [kubernetes_namespace.argowf](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)
- [kubernetes_namespace.hybrid_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)
- [kubernetes_role.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) (resource)
- [kubernetes_role_binding.cron](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) (resource)
- [kubernetes_secret.argowf_db_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) (resource)
- [kubernetes_secret.ecr_registry_helper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) (resource)
- [kubernetes_service_account_v1.omd_cron_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) (resource)
- [random_password.argowf_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)
- [random_string.storage_account_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) (resource)
- [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) (data source)
- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) (data source)
- [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_ECR_ACCESS_KEY"></a> [ECR\_ACCESS\_KEY](#input\_ECR\_ACCESS\_KEY)

Description: The Access key shared by Collate to pull Docker images from ECR.

Type: `string`

### <a name="input_ECR_SECRET_KEY"></a> [ECR\_SECRET\_KEY](#input\_ECR\_SECRET\_KEY)

Description: The Secret Key shared by Collate to pull Docker images from ECR.

Type: `string`

### <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name)

Description: Name of the existing AKS cluster.

Type: `string`

### <a name="input_aks_resource_group_name"></a> [aks\_resource\_group\_name](#input\_aks\_resource\_group\_name)

Description: Name of the resource group containing the AKS cluster.

Type: `string`

### <a name="input_argowf"></a> [argowf](#input\_argowf)

Description: Argo Workflows configuration.

Type:

```hcl
object({
    provisioner            = optional(string)
    endpoint               = optional(string)
    helm_chart_version     = optional(string)
    namespace              = optional(string)
    controller_sa_name     = optional(string)
    server_sa_name         = optional(string)
    storage_account_name   = optional(string)
    storage_container_name = optional(string)
    crd_enabled            = optional(bool)
    db = optional(object({
      apply_immediately     = optional(bool)
      name                  = optional(string)
      sku_name              = optional(string)
      version               = optional(string)
      administrator_login   = optional(string)
      credentials_secret    = optional(string)
      storage_mb            = optional(number)
      backup_retention_days = optional(number)
      auto_grow_enabled     = optional(bool)
    }))
  })
```

### <a name="input_collate_auth_token"></a> [collate\_auth\_token](#input\_collate\_auth\_token)

Description: The token used to authenticate with the Collate server.

Type: `string`

### <a name="input_collate_server_domain"></a> [collate\_server\_domain](#input\_collate\_server\_domain)

Description: The domain of the Collate server. ie: bigcorp.getcollate.io

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_docker_image_pull_secret"></a> [docker\_image\_pull\_secret](#input\_docker\_image\_pull\_secret)

Description: The Docker image pull secret for the Hybrid Ingestion Runner.

Type: `string`

Default: `null`

### <a name="input_docker_image_repository"></a> [docker\_image\_repository](#input\_docker\_image\_repository)

Description: The Docker image repository for the Hybrid Ingestion Runner.

Type: `string`

Default: `null`

### <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag)

Description: The Docker image tag for the Hybrid Ingestion Runner.

Type: `string`

Default: `null`

### <a name="input_environment"></a> [environment](#input\_environment)

Description: The environment name where the resources will be deployed.

Type: `string`

Default: `"prod"`

### <a name="input_ingestion"></a> [ingestion](#input\_ingestion)

Description: Ingestion pods helm configurations.

Type:

```hcl
object({
    image = optional(object({
      repository   = optional(string)
      tag          = optional(string)
      pull_secrets = optional(string)
    }))
    extra_envs      = optional(string)
    pod_annotations = optional(map(string))
  })
```

Default: `null`

### <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name)

Description: The name of the Azure Key Vault to retrieve for stored credentials.

Type: `string`

Default: `null`

### <a name="input_key_vault_resource_group_name"></a> [key\_vault\_resource\_group\_name](#input\_key\_vault\_resource\_group\_name)

Description: The resource group name where the Azure Key Vault is located.

Type: `string`

Default: `null`

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resources will be deployed.

Type: `string`

Default: `"westeurope"`

### <a name="input_namespace"></a> [namespace](#input\_namespace)

Description: The application's namespace prefix. Note that `var.environment` will be appended to this value.

Type: `string`

Default: `"collate-hybrid-ingestion-runner"`

### <a name="input_release_version"></a> [release\_version](#input\_release\_version)

Description: The Hybrid Ingestion Runner version to deploy.

Type: `string`

Default: `"1.8.10"`

### <a name="input_runner_id"></a> [runner\_id](#input\_runner\_id)

Description: Runner identifier that will be assigned to an ingestion pipeline. The name you will see in the Collate UI.

Type: `string`

Default: `null`

### <a name="input_service_monitor_enabled"></a> [service\_monitor\_enabled](#input\_service\_monitor\_enabled)

Description: Enable service monitor for Prometheus metrics.

Type: `bool`

Default: `false`

### <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id)

Description: Azure subscription ID (optional).

Type: `string`

Default: `null`

### <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id)

Description: Azure AD tenant ID (optional).

Type: `string`

Default: `null`

## Outputs

No outputs.
