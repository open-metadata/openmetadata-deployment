# Terraform project for deploying Collate Ingestion Runner in AWS

## Prerequisites

- Administrator access on the AWS account and EKS cluster
- An EKS cluster
  - version >= 1.28
  - [OIDC provider](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)
- A VPC with at least 2 subnets, private recommended

## Usage

Create a file named `terraform.tfvars` with the mandatory variables, you can use this as an example:

```hcl
# EKS cluster name
eks_cluster     = "eks-cluster"
# AWS region
region          = "eu-west-1"

# Collate authentication
collate_auth_token = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
collate_server_url = "wss://my-company.getcollate.io"

# Argo Workflows settings
argowf = {
  # Security group assigned to the EKS nodes, used to allow access to the database
  eks_nodes_sg_ids = ["sg-XXXXXXXXXXXXX"]
  db = {
    # VPC & subnets, used to deploy the database
    vpc_id              = "vpc-0123456789"
    subnet_ids          = ["subnet-00000000000001", "subnet-00000000000002"]
  }
}

# ECR credentials to pull the Docker images
ECR_ACCESS_KEY = "" # provided by Collate
ECR_SECRET_KEY = "" # provided by Collate
```

Then run the following commands:

```bash
  terraform init && terraform apply
```

This will create the necessary resources in your AWS account. 

## Settings

You can check the extended Terraform documentation for this project [here](README_terraform_docs.md).

The variables listed in this section have default values, you can skip their definition if you are fine with them.

### Versions
 - `release_version`: The Hybrid Ingestion Runner version to deploy.
 - `argowf.helm_chart_version`: The Argo Workflows Helm chart version to deploy. Change this only if Collate requires it.

### KMS key

- `kms_key_id` The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified.

### Database

By default this project will create one PostgreSQL database instance for Argo Workflows.

Argo Workflows database parameters are defined in the variable `argowf.db`, ie.:
 - `instance_class`: Database instance type
 - `instance_name`: Name of the database instance
 - `multi_az`: Multi-AZ deployment for the database
 - `deletion_protection`: Deletion protection for the database
 - `skip_final_snapshot`: Skip final snapshot for the database

### S3 bucket

- `argowf.s3_bucket_name`: Name of the S3 bucket to use for the Argo Workflows logs. If not specified, a random name will be generated with the `namespace-` prefix.
