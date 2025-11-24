<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.70.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.15.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db_omd"></a> [db\_omd](#module\_db\_omd) | terraform-aws-modules/rds/aws | ~>6.10 |
| <a name="module_irsa_role_argowf_controller"></a> [irsa\_role\_argowf\_controller](#module\_irsa\_role\_argowf\_controller) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_irsa_role_argowf_jobs"></a> [irsa\_role\_argowf\_jobs](#module\_irsa\_role\_argowf\_jobs) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_irsa_role_argowf_server"></a> [irsa\_role\_argowf\_server](#module\_irsa\_role\_argowf\_server) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_opensearch_sg"></a> [opensearch\_sg](#module\_opensearch\_sg) | terraform-aws-modules/security-group/aws | ~>5.2 |
| <a name="module_rds_argo_workflows"></a> [rds\_argo\_workflows](#module\_rds\_argo\_workflows) | terraform-aws-modules/rds/aws | ~>6.10 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~>4.2 |
| <a name="module_sg_argo_db"></a> [sg\_argo\_db](#module\_sg\_argo\_db) | terraform-aws-modules/security-group/aws | ~>5.1 |
| <a name="module_sg_db"></a> [sg\_db](#module\_sg\_db) | terraform-aws-modules/security-group/aws | ~>5.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.argowf_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.argowf_jobs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.argowf_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_opensearch_domain.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [helm_release.argowf](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.openmetadata](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.ecr_registry_helper_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_manifest.ecr_registry_helper_cronjob](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.ecr_registry_helper_one_shot](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.argowf](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role.om-argo-role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.cron](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.om-argo-role-binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.argowf_db_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.db_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.ecr_registry_helper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.om_role_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.opensearch_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account_v1.om_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [kubernetes_service_account_v1.omd_cron_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [random_password.argowf_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.opensearch_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.s3_bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_openid_connect_provider.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.argowf_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.argowf_jobs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.argowf_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ECR_ACCESS_KEY"></a> [ECR\_ACCESS\_KEY](#input\_ECR\_ACCESS\_KEY) | The Access key shared by Collate to pull Docker images from ECR. | `string` | n/a | yes |
| <a name="input_ECR_SECRET_KEY"></a> [ECR\_SECRET\_KEY](#input\_ECR\_SECRET\_KEY) | The Secret Key shared by Collate to pull Docker images from ECR. | `string` | n/a | yes |
| <a name="input_app_helm_chart_version"></a> [app\_helm\_chart\_version](#input\_app\_helm\_chart\_version) | The version of the OpenMetadata Helm chart to deploy. If not specified, the variable `app_version` will be used. | `string` | `null` | no |
| <a name="input_app_namespace"></a> [app\_namespace](#input\_app\_namespace) | Namespace to deploy the OpenMetadata application. | `string` | `"openmetadata"` | no |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | The version of the OpenMetadata application to deploy. | `string` | `"1.11.0-rc1"` | no |
| <a name="input_argowf_db_instance_class"></a> [argowf\_db\_instance\_class](#input\_argowf\_db\_instance\_class) | Argo Workflows database instance type. | `string` | `"db.t4g.micro"` | no |
| <a name="input_argowf_db_instance_name"></a> [argowf\_db\_instance\_name](#input\_argowf\_db\_instance\_name) | Name of the Argo Workflows database instance. | `string` | `"argowf"` | no |
| <a name="input_argowf_db_iops"></a> [argowf\_db\_iops](#input\_argowf\_db\_iops) | The amount of provisioned IOPS for Argo Workflows database. Setting this implies a db\_storage\_type of 'io1' or `gp3`. | `number` | `null` | no |
| <a name="input_argowf_db_major_version"></a> [argowf\_db\_major\_version](#input\_argowf\_db\_major\_version) | Argo Workflows database major version. For PostgreSQL, must be a string representing a version between '12' and '16', inclusive. | `string` | `"16"` | no |
| <a name="input_argowf_db_storage"></a> [argowf\_db\_storage](#input\_argowf\_db\_storage) | Argo Workflows database storage size. | `string` | `50` | no |
| <a name="input_argowf_db_storage_throughput"></a> [argowf\_db\_storage\_throughput](#input\_argowf\_db\_storage\_throughput) | Argo Workflows storage throughput value for the DB instance. Setting this implies a db\_storage\_type of 'io1' or `gp3`. | `number` | `null` | no |
| <a name="input_argowf_db_storage_type"></a> [argowf\_db\_storage\_type](#input\_argowf\_db\_storage\_type) | Argo Workflows database storage type. | `string` | `"gp3"` | no |
| <a name="input_argowf_helm_chart_version"></a> [argowf\_helm\_chart\_version](#input\_argowf\_helm\_chart\_version) | The version of the Argo Workflows Helm chart to deploy. | `string` | `"0.40.8"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | OpenMetadata database instance type. | `string` | `"db.m7g.large"` | no |
| <a name="input_db_instance_name"></a> [db\_instance\_name](#input\_db\_instance\_name) | Name of the OpenMetadata database instance. | `string` | `"openmetadata"` | no |
| <a name="input_db_iops"></a> [db\_iops](#input\_db\_iops) | The amount of provisioned IOPS for OpenMetadata database. Setting this implies a db\_storage\_type of 'io1' or `gp3`. | `number` | `null` | no |
| <a name="input_db_major_version"></a> [db\_major\_version](#input\_db\_major\_version) | OpenMetadata database major version. For PostgreSQL, must be a string representing a version between '12' and '16', inclusive. | `string` | `"16"` | no |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | List of parameters to use in the OpenMetadata database parameter group. | `list(map(string))` | `[]` | no |
| <a name="input_db_storage"></a> [db\_storage](#input\_db\_storage) | OpenMetadata database storage size. | `string` | `100` | no |
| <a name="input_db_storage_throughput"></a> [db\_storage\_throughput](#input\_db\_storage\_throughput) | OpenMetadata storage throughput value for the DB instance. Setting this implies a db\_storage\_type of 'io1' or `gp3`. | `number` | `null` | no |
| <a name="input_db_storage_type"></a> [db\_storage\_type](#input\_db\_storage\_type) | OpenMetadata database storage type. | `string` | `"gp3"` | no |
| <a name="input_docker_image_name"></a> [docker\_image\_name](#input\_docker\_image\_name) | Full path of the server Docker image name, excluding the tag. | `string` | `"118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-eu-west-1"` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | Docker image tag for both the server and ingestion. If not specified, the variable `app_version` will be used. | `string` | `null` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster where OpenMetadata will be deployed. | `string` | n/a | yes |
| <a name="input_eks_nodes_sg_ids"></a> [eks\_nodes\_sg\_ids](#input\_eks\_nodes\_sg\_ids) | List of security group IDs attached to the EKS nodes. Used to allow traffic from the OpenMetadata application to the databases. | `list(string)` | `[]` | no |
| <a name="input_ingestion_image_name"></a> [ingestion\_image\_name](#input\_ingestion\_image\_name) | Full path of the ingestion Docker image name, excluding the tag. | `string` | `"118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1"` | no |
| <a name="input_initial_admins"></a> [initial\_admins](#input\_initial\_admins) | List of initial admins to create in the OpenMetadata application. Do not include the domain name. | `list(string)` | <pre>[<br/>  "admin"<br/>]</pre> | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified. | `string` | `null` | no |
| <a name="input_opensearch_name"></a> [opensearch\_name](#input\_opensearch\_name) | The OpenSearch domain name. | `string` | `"openmetadata"` | no |
| <a name="input_principal_domain"></a> [principal\_domain](#input\_principal\_domain) | The domain name of the users. For example, `open-metadata.org`. | `string` | `"open-metadata.org"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region name, for example:`us-east-2`. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of S3 bucket for storing the Argo Workflows logs and OpenMetadata assets. If not specified, a random name will be generated with the `openmetadata-` prefix. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets IDs where the databases and OpenSearch will be deployed. The recommended configuration is to use private subnets. | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to deploy the databases and OpenSearch. For example: `vpc-xxxxxxxx`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_openmetadata"></a> [access\_openmetadata](#output\_access\_openmetadata) | n/a |
<!-- END_TF_DOCS -->
