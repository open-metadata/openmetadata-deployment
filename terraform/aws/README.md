<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.28.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.24.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_argo_workflows"></a> [rds\_argo\_workflows](#module\_rds\_argo\_workflows) | terraform-aws-modules/rds/aws | ~>6.3 |
| <a name="module_sg_db"></a> [sg\_db](#module\_sg\_db) | terraform-aws-modules/security-group/aws | ~>5.1 |

## Resources

| Name | Type |
|------|------|
| [aws_opensearch_domain.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_security_group.opensearch_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [helm_release.argowf](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.openmetadata](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.ecr_registry_helper_k8s_config_map](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_cron_job_v1.ecr_registry_helper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cron_job_v1) | resource |
| [kubernetes_namespace.argowf](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role.cron-role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role.om-argo-role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.cron_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.om-argo-role-binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.ecr_registry_helper_k8s_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.mysql_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.om_role_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.opensearch_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account_v1.om_argo_cron_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [kubernetes_service_account_v1.om_argo_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [random_password.mysql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.opensearch_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.get_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DOCKER_SECRET_NAME"></a> [DOCKER\_SECRET\_NAME](#input\_DOCKER\_SECRET\_NAME) | Provide the name of secret to be created for authentication in aws | `string` | `"ecr-registry-creds"` | no |
| <a name="input_ECR_ACCESS_KEY"></a> [ECR\_ACCESS\_KEY](#input\_ECR\_ACCESS\_KEY) | Provide the Access key shared from Collate to pull docker images | `string` | n/a | yes |
| <a name="input_ECR_SECRET_KEY"></a> [ECR\_SECRET\_KEY](#input\_ECR\_SECRET\_KEY) | Provide the Secret Key shared from Collate to pull docker images | `string` | n/a | yes |
| <a name="input_admin_name"></a> [admin\_name](#input\_admin\_name) | Name of the database admin user | `string` | `"root"` | no |
| <a name="input_alarm_sns_topic"></a> [alarm\_sns\_topic](#input\_alarm\_sns\_topic) | SNS Topic Name for CloudWatch Alarms | `string` | `"sns-admin-prod"` | no |
| <a name="input_allow_from_sgs"></a> [allow\_from\_sgs](#input\_allow\_from\_sgs) | Allow access from these security group ids | `list(string)` | `[]` | no |
| <a name="input_apply_rds_changes_immediately"></a> [apply\_rds\_changes\_immediately](#input\_apply\_rds\_changes\_immediately) | Whether to apply RDS changes immediately. Otherwise it will be scheduled during db\_maintenance\_window | `bool` | `false` | no |
| <a name="input_argoIngestionImage"></a> [argoIngestionImage](#input\_argoIngestionImage) | Provide the name of ingestion image for Openmetadata in the format like `118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1:om-1.2.2-cl-1.2.2` | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Provide the name of bucket for storing the argoworkflow logs | `string` | `"argo-workflow-log"` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | DB engine | `string` | `"postgres"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | DB instance type | `string` | `"db.t4g.micro"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of the initial database for RDS instance | `string` | `"argowf"` | no |
| <a name="input_db_storage"></a> [db\_storage](#input\_db\_storage) | DB storage capacity | `string` | `10` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Provide the name of EKS cluster | `string` | n/a | yes |
| <a name="input_imageTag"></a> [imageTag](#input\_imageTag) | Provide the Openmetadata application image tag in a specific format like `om-1.2.2-cl-1.2.2` | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the RDS instance | `string` | `"rds-argo-workflows"` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | Tags to apply to the instance | `map(string)` | `{}` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key to encrypt db and backups. Default will be used if not provided | `string` | `null` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | DB major version | `string` | `"15"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Deploy the database in multiple availability zones | `bool` | `true` | no |
| <a name="input_opensearch_name"></a> [opensearch\_name](#input\_opensearch\_name) | Provide the OpenSearch Instance name | `string` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Provide the name of RDS Parameter group by client | `string` | `"saas-collate"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters to pass to the DB parameter group | `list(map(string))` | <pre>[<br>  {<br>    "name": "sort_buffer_size",<br>    "value": "4194304"<br>  }<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | Provide the region name for example:`us-east-2` | `string` | n/a | yes |
| <a name="input_snapshot_retention"></a> [snapshot\_retention](#input\_snapshot\_retention) | Number of days to retain the DB backup | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Provide the VPC ID for example: `vpc-xxxxxxxxxx` | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->