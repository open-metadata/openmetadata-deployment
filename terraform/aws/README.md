## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db_omd"></a> [db\_omd](#module\_db\_omd) | terraform-aws-modules/rds/aws | ~>6.3 |
| <a name="module_irsa_role_argowf_controller"></a> [irsa\_role\_argowf\_controller](#module\_irsa\_role\_argowf\_controller) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_irsa_role_argowf_server"></a> [irsa\_role\_argowf\_server](#module\_irsa\_role\_argowf\_server) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_opensearch_sg"></a> [opensearch\_sg](#module\_opensearch\_sg) | terraform-aws-modules/security-group/aws | ~>5.1 |
| <a name="module_rds_argo_workflows"></a> [rds\_argo\_workflows](#module\_rds\_argo\_workflows) | terraform-aws-modules/rds/aws | ~>6.3 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~>3.15 |
| <a name="module_sg_argo_db"></a> [sg\_argo\_db](#module\_sg\_argo\_db) | terraform-aws-modules/security-group/aws | ~>5.1 |
| <a name="module_sg_db"></a> [sg\_db](#module\_sg\_db) | terraform-aws-modules/security-group/aws | ~>5.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.argowf_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.argowf_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_opensearch_domain.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [helm_release.argowf](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.openmetadata](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.ecr_registry_helper_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_cron_job_v1.ecr_registry_helper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cron_job_v1) | resource |
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
| [kubernetes_secret.opensearch_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account_v1.om_argo_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [kubernetes_service_account_v1.omd_cron_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [random_password.argowf_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.opensearch_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.argowf_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.argowf_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ECR_ACCESS_KEY"></a> [ECR\_ACCESS\_KEY](#input\_ECR\_ACCESS\_KEY) | Provide the Access key shared from Collate to pull docker images | `string` | n/a | yes |
| <a name="input_ECR_SECRET_KEY"></a> [ECR\_SECRET\_KEY](#input\_ECR\_SECRET\_KEY) | Provide the Secret Key shared from Collate to pull docker images | `string` | n/a | yes |
| <a name="input_app_namespace"></a> [app\_namespace](#input\_app\_namespace) | Namespace to deploy the OpenMetadata application | `string` | `"openmetadata"` | no |
| <a name="input_argowf_bucket_name"></a> [argowf\_bucket\_name](#input\_argowf\_bucket\_name) | Provide the name of bucket for storing the argoworkflow logs | `string` | `"argo-workflow-log"` | no |
| <a name="input_argowf_db_instance_class"></a> [argowf\_db\_instance\_class](#input\_argowf\_db\_instance\_class) | ArgoWf DB instance type | `string` | `"db.t4g.micro"` | no |
| <a name="input_argowf_db_instance_name"></a> [argowf\_db\_instance\_name](#input\_argowf\_db\_instance\_name) | Name of the ArgoWf DB instance | `string` | `"argowf"` | no |
| <a name="input_argowf_db_major_version"></a> [argowf\_db\_major\_version](#input\_argowf\_db\_major\_version) | ArgoWf DB major version | `string` | `"15"` | no |
| <a name="input_argowf_db_storage"></a> [argowf\_db\_storage](#input\_argowf\_db\_storage) | ArgoWf DB storage size | `string` | `10` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | OpenMetadata DB instance type | `string` | `"db.m7g.xlarge"` | no |
| <a name="input_db_instance_name"></a> [db\_instance\_name](#input\_db\_instance\_name) | Name of the OpenMetadata DB instance | `string` | `"openmetadata"` | no |
| <a name="input_db_major_version"></a> [db\_major\_version](#input\_db\_major\_version) | OpenMetadata DB major version | `string` | `"15"` | no |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | Parameters to pass to the DB parameter group | `list(map(string))` | <pre>[<br>  {<br>    "name": "sort_buffer_size",<br>    "value": "4194304"<br>  }<br>]</pre> | no |
| <a name="input_db_storage"></a> [db\_storage](#input\_db\_storage) | OpenMetadata DB storage size | `string` | `120` | no |
| <a name="input_docker_image_name"></a> [docker\_image\_name](#input\_docker\_image\_name) | Full path of the image name, excluding tag | `string` | `"118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-eu-west-1"` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | Image tag for both the server and ingestion. Leave empty for default | `string` | `""` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of EKS cluster | `string` | n/a | yes |
| <a name="input_eks_nodes_sg_ids"></a> [eks\_nodes\_sg\_ids](#input\_eks\_nodes\_sg\_ids) | Allow access from these security group ids to databases | `list(string)` | `[]` | no |
| <a name="input_ingestion_image_name"></a> [ingestion\_image\_name](#input\_ingestion\_image\_name) | Full path of the ingestion image name, excluding tag | `string` | `"118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key to encrypt db and backups. Default will be used if not provided | `string` | `null` | no |
| <a name="input_opensearch_name"></a> [opensearch\_name](#input\_opensearch\_name) | Provide the OpenSearch Instance name | `string` | `"openmetadata"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region name, for example:`us-east-2` | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Create databases in these subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to deploy databases and elasticsearch. For example: `vpc-xxxxxxxxxx` | `string` | n/a | yes |

## Outputs

No outputs.
