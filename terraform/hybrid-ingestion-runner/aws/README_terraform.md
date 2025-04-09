## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.93.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa_role_argowf_controller"></a> [irsa\_role\_argowf\_controller](#module\_irsa\_role\_argowf\_controller) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_irsa_role_argowf_server"></a> [irsa\_role\_argowf\_server](#module\_irsa\_role\_argowf\_server) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.22 |
| <a name="module_rds_argo_workflows"></a> [rds\_argo\_workflows](#module\_rds\_argo\_workflows) | terraform-aws-modules/rds/aws | ~>6.11 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~>4.6 |
| <a name="module_sg_argo_db"></a> [sg\_argo\_db](#module\_sg\_argo\_db) | terraform-aws-modules/security-group/aws | ~>5.3 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.argowf_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.argowf_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [helm_release.argowf](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.hybrid_runner](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.ecr_registry_helper_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_manifest.ecr_registry_helper_cronjob](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.ecr_registry_helper_one_shot](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.argowf](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.hybrid_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.cron](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.argowf_db_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.ecr_registry_helper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account_v1.omd_cron_sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [random_password.argowf_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.s3_bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_openid_connect_provider.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.argowf_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.argowf_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ECR_ACCESS_KEY"></a> [ECR\_ACCESS\_KEY](#input\_ECR\_ACCESS\_KEY) | The Access key shared by Collate to pull Docker images from ECR. | `string` | n/a | yes |
| <a name="input_ECR_SECRET_KEY"></a> [ECR\_SECRET\_KEY](#input\_ECR\_SECRET\_KEY) | The Secret Key shared by Collate to pull Docker images from ECR. | `string` | n/a | yes |
| <a name="input_argowf"></a> [argowf](#input\_argowf) | Argo Workflows configuration. | <pre>object({<br/>    provisioner        = optional(string)       # Provisioner for the Argo Workflows controller. Options: `helm` or `existing`<br/>    endpoint           = optional(string)       # Endpoint for the Argo Workflows server. Only used if `provisioner` is `existing`<br/>    helm_chart_version = optional(string)       # Version of the Argo Workflows Helm chart to deploy<br/>    namespace          = optional(string)       # Namespace where Argo Workflows will be deployed<br/>    controller_sa_name = optional(string)       # Name of the service account for the Argo Workflows controller<br/>    server_sa_name     = optional(string)       # Name of the service account for the Argo Workflows server<br/>    s3_bucket_name     = optional(string)       # Name of the S3 bucket for storing Argo Workflows logs<br/>    eks_nodes_sg_ids   = optional(list(string)) # List of security group IDs attached to the EKS nodes. Used to allow traffic from Argo Workflows to its database<br/>    crd_enabled        = optional(bool)         # Enable CRD for Argo Workflows<br/>    db = optional(object({<br/>      apply_immediately       = optional(bool)         # Apply changes immediately<br/>      instance_class          = optional(string)       # Database instance type<br/>      instance_name           = optional(string)       # Name of the database instance<br/>      name                    = optional(string)       # Database name<br/>      user                    = optional(string)       # Database user<br/>      credentials_secret      = optional(string)       # Kubernetes secret that stores the database credentials<br/>      iops                    = optional(number)       # Provisioned IOPS for the database<br/>      major_version           = optional(string)       # Major version of the database<br/>      storage                 = optional(string)       # Storage size for the database<br/>      storage_type            = optional(string)       # Storage type for the database<br/>      storage_throughput      = optional(number)       # Storage throughput for the database<br/>      multi_az                = optional(bool)         # Multi-AZ deployment for the database<br/>      deletion_protection     = optional(bool)         # Deletion protection for the database<br/>      skip_final_snapshot     = optional(bool)         # Skip final snapshot for the database<br/>      maintenance_window      = optional(string)       # Maintenance window for the database<br/>      backup_window           = optional(string)       # Backup window for the database<br/>      backup_retention_period = optional(number)       # Backup retention period for the database<br/>      vpc_id                  = optional(string)       # VPC ID for the database<br/>      subnet_ids              = optional(list(string)) # List of subnet IDs for the database. Private subnets are recommended<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_collate_auth_token"></a> [collate\_auth\_token](#input\_collate\_auth\_token) | The token used to authenticate with the Collate server. | `string` | n/a | yes |
| <a name="input_collate_server_url"></a> [collate\_server\_url](#input\_collate\_server\_url) | The URL of the Collate server. | `string` | n/a | yes |
| <a name="input_docker_image_repository"></a> [docker\_image\_repository](#input\_docker\_image\_repository) | The Docker image repository for the Hybrid Ingestion Runner. | `string` | `null` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | The Docker image tag for the Hybrid Ingestion Runner. | `string` | `null` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster where the resources will be deployed. | `string` | n/a | yes |
| <a name="input_ingestion"></a> [ingestion](#input\_ingestion) | Ingestiopn pods settings | <pre>object({<br/>    image = optional(object({<br/>      repository = optional(string) # Docker image repository<br/>      tag        = optional(string) # Docker image tag<br/>    }))<br/>    extra_envs      = optional(string)      # Extra environment variables for the pods, as `[key1:value1,key2:value2,...]`<br/>    pod_annotations = optional(map(string)) # Annotations for the pods<br/>  })</pre> | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The application's namespace. | `string` | `"collate-hybrid-ingestion-runner"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources will be deployed. | `string` | `"eu-west-1"` | no |
| <a name="input_release_version"></a> [release\_version](#input\_release\_version) | The Hybrid Ingestion Runner version to deploy. | `string` | `"0.0.1"` | no |
| <a name="input_runner_id"></a> [runner\_id](#input\_runner\_id) | Runner identifier that will be assigned to an ingestion pipeline. The name you will see in the Collate UI. | `string` | `null` | no |
| <a name="input_service_monitor_enabled"></a> [service\_monitor\_enabled](#input\_service\_monitor\_enabled) | Enable service monitor for Prometheus metrics. | `bool` | `false` | no |

## Outputs

No outputs.