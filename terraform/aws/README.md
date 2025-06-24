# Terraform project for deploying Collate BYOC in AWS

## Prerequisites

- Administrator access on the AWS account and EKS cluster
- An EKS cluster
  - version >= 1.28
  - [OIDC provider](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)
- A VPC with at least 2 subnets, private recommended

## Usage

Create a file named `terraform.tfvars` with the mandatory variables, you can use this as an example:

```hcl
app_version = "1.8.1"

# Example for authentication using admin@mycompany.com
initial_admins   = ["admin"] 
principal_domain = "mycompany.com"

region     = "us-east-1"
vpc_id     = "vpc-0123456789abcdef0"
subnet_ids = ["subnet-0000000az1", "subnet-0000000az2"] # At least 2 subnets are required

eks_cluster      = "my_eks_cluster"
eks_nodes_sg_ids = ["sg-0123456789abcdef0"]

ECR_ACCESS_KEY = "" # provided by Collate
ECR_SECRET_KEY = "" # provided by Collate
```

Then run the following commands:

```bash
  terraform init && terraform apply
```

This will create the necessary resources in your AWS account. 

At this stage you should be able to connect to the deployed OpenMetadata via the Kubernetes service. For this, you can use the following command:

```bash
  kubectl port-forward service/openmetadata 8585:8585 -n openmetadata
```

And then open your browser at <http://localhost:8585>.


## Settings

You can check the extended Terraform documentation for this project [here](README_terraform_docs.md).

The variables listed in this section have default values, you can skip their definition if you are fine with them.

### Versions

 - `app_version` The OpenMetadata version to deploy.
 - `app_helm_chart_version` The OpenMetadata Helm chart version to deploy. If not specified, `app_version` will be used.
 - `argowf_helm_chart_version` The Argo Workflows Helm chart version to deploy. Change this only if OpenMetadata requires it.
 - `docker_image_tag` The Docker image tag to use for the OpenMetadata deployment. If not specified, `app_version` will be used.

### KMS key

- `kms_key_id` The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified.

### Databases

By default this project will create one database instance for OpenMetadata and another for Argo Workflows. In both cases the database will be PostgreSQL.

OpenMetadata database:

- `db_instance_class` OpenMetadata database instance type.
- `db_storage` OpenMetadata database storage size.

Argo Workflows database:

- `argowf_db_instance_class` Argo Workflows database instance type.
- `argowf_db_storage` Argo Workflows database storage size.
 
### S3 bucket

- `s3_bucket_name` Name of the S3 bucket to use for OpenMetadata. If not specified, a random name will be generated with the `openmetadata-` prefix.

### OpenSearch

- `opensearch_name` The OpenSearch domain name.
