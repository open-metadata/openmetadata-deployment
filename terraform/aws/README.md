<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.28.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.24.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_argo_workflows"></a> [rds\_argo\_workflows](#module\_rds\_argo\_workflows) | git@github.com:open-metadata/terraform-rds-instance.git | v0.1.3 |

## Resources

| Name | Type |
|------|------|
| [aws_opensearch_domain.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_security_group.opensearch_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [helm_release.argowf](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.openmetadata](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.openmetadata_dependencies](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
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
| [random_password.opensearch_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.get_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACCESS_KEY"></a> [ACCESS\_KEY](#input\_ACCESS\_KEY) | Provide the Access Key | `string` | n/a | yes |
| <a name="input_SECRET_KEY"></a> [SECRET\_KEY](#input\_SECRET\_KEY) | Provide the Secret Key | `string` | n/a | yes |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Provide the name of EKS cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Provide the region name for example:`us-east-2` | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Provide the VPC ID for example: `vpc-xxxxxxxxxx` | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->