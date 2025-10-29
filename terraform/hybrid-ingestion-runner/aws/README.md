# Terraform project for deploying Collate Ingestion Runner in AWS

## Prerequisites

- Administrator access on the AWS account and EKS cluster
- An EKS cluster
  - version >= 1.28
  - [OIDC provider](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)

## Usage

Create a file named `terraform.tfvars` with the mandatory variables, you can use this as an example updating the values:

```hcl
# EKS cluster name
eks_cluster     = "eks-cluster"
# AWS region
region          = "eu-west-1"

# Environment name. Must be unique in the AWS Region
environment     = "sandbox"

# Collate server authentication
collate_auth_token = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
collate_server_domain = "my-company.getcollate.io"

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

## Ingestion Pods

### Access to the AWS Secrets Manager

The ingestion pods require access to AWS Secrets Manager to retrieve the credentials needed to connect to your resources. The path to the Secrets Manager that will be allowed is defined by the variable `secrets_manager_path`, which defaults to `/collate/hybrid-ingestion-runner`. You can modify this value if you'd like to use a different path.

The AWS Secrets Manager must be in the AWS Region selected in the variable: `region`.  

### Attach additional IAM policies to the ingestion pods

The ingestion pods run using the IAM role named `ingestion-pods-<AWS region>` by default. This role is created by this Terraform project and is attached to the ingestion pods. If you want to attach additional policies you can use the variable `ingestion.extra_policies_arn`, please check the following example:

```hcl
ingestion = {
  extra_policies_arn = [
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
    "arn:aws:iam::aws:policy/service-role/AWSGlueConsoleFullAccess"
  ]
}
```

## Common errors

### Error: Failed to query available provider packages and Inconsistent dependency lock file

If you encounter the following errors when running `terraform init`, `terraform plan` or `terraform apply`:

```bash
╷
│ Error: Inconsistent dependency lock file
│ 
│ The following dependency selections recorded in the lock file are inconsistent with the current configuration:
│   - provider registry.terraform.io/hashicorp/aws: locked version selection 5.93.0 doesn't match the updated version constraints ">= 3.29.0, >= 4.0.0, >= 5.83.0, >= 5.92.0, ~> 6.0"
│   - provider registry.terraform.io/hashicorp/helm: locked version selection 2.17.0 doesn't match the updated version constraints "~> 3.0"
│ 
│ To update the locked dependency selections to match a changed configuration, run:
│   terraform init -upgrade
```

```bash
Initializing the backend...
Initializing modules...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/helm from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Using previously-installed hashicorp/helm v3.0.2
- Using previously-installed hashicorp/kubernetes v2.38.0
- Using previously-installed hashicorp/random v3.7.2
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider hashicorp/aws: locked provider registry.terraform.io/hashicorp/aws 5.100.0 does not match configured version
│ constraint >= 3.29.0, >= 4.0.0, >= 5.83.0, >= 5.92.0, ~> 6.0; must use terraform init -upgrade to allow selection of new versions
│ 
│ To see which modules are currently depending on hashicorp/aws and what versions are specified, run the following command:
│     terraform providers
```

You can fix this by running the following command:

```bash
terraform init -upgrade
```

## Breaking changes
### 1.10
- RDS Database and S3 bucket are no longer needed and they will be removed