variable "eks_cluster" {
  type        = string
  description = "Name of the EKS cluster where the resources will be deployed."
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified."
  default     = null
}

variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "The region where the resources will be deployed."
}

# hybrid ingestion runner

variable "release_version" {
  type        = string
  description = "The Hybrid Ingestion Runner version to deploy."
  default     = "1.9.14"
}

variable "namespace" {
  type        = string
  default     = "collate-hybrid-ingestion-runner"
  description = "The application's namespace prefix. Note that `var.environment` will be appended to this value."
}

variable "environment" {
  type        = string
  description = "The environment name where the resources will be deployed. Must be unique within the AWS Region."
  default     = "prod"
}

variable "docker_image_repository" {
  type        = string
  description = "The Docker image repository for the Hybrid Ingestion Runner."
  default     = null
}

variable "docker_image_tag" {
  type        = string
  description = "The Docker image tag for the Hybrid Ingestion Runner."
  default     = null
}

variable "docker_image_pull_secret" {
  type        = string
  description = "The Docker image pull secret for the Hybrid Ingestion Runner."
  default     = null
}

variable "docker_image_pull_policy" {
  type        = string
  description = "The Docker image pull policy for the Hybrid Ingestion Runner."
  default     = "IfNotPresent"
}

variable "runner_id" {
  type        = string
  description = "Runner identifier that will be assigned to an ingestion pipeline. The name you will see in the Collate UI."
  default     = null
}

variable "collate_auth_token" {
  type        = string
  description = "The token used to authenticate with the Collate server."
}

variable "collate_server_domain" {
  type        = string
  description = "The domain of the Collate server. ie: bigcorp.getcollate.io"
}

variable "service_monitor_enabled" {
  type        = bool
  description = "Enable service monitor for Prometheus metrics."
  default     = false
}

variable "secrets_manager_path" {
  type        = string
  description = "The AWS Secrets Manager path that the Ingestion Pods will be allowed to read from."
  default     = "/collate/hybrid-ingestion-runner"
}

# ECR Creds 
variable "ECR_ACCESS_KEY" {
  type        = string
  description = "The Access key shared by Collate to pull Docker images from ECR."
}

variable "ECR_SECRET_KEY" {
  type        = string
  description = "The Secret Key shared by Collate to pull Docker images from ECR."
}

variable "argowf" {
  description = "Argo Workflows configuration."
  type = object({
    provisioner        = optional(string)       # Provisioner for the Argo Workflows controller. Options: `helm` or `existing`
    endpoint           = optional(string)       # Endpoint for the Argo Workflows server. Only used if `provisioner` is `existing`
    helm_chart_version = optional(string)       # Version of the Argo Workflows Helm chart to deploy
    namespace          = optional(string)       # Namespace where Argo Workflows will be deployed
    controller_sa_name = optional(string)       # Name of the service account for the Argo Workflows controller
    server_sa_name     = optional(string)       # Name of the service account for the Argo Workflows server
    s3_bucket_name     = optional(string)       # Name of the S3 bucket for storing Argo Workflows logs
    eks_nodes_sg_ids   = optional(list(string)) # List of security group IDs attached to the EKS nodes. Used to allow traffic from Argo Workflows to its database
    crd_enabled        = optional(bool)         # Enable CRD for Argo Workflows
    db = optional(object({
      apply_immediately       = optional(bool)         # Apply changes immediately
      instance_class          = optional(string)       # Database instance type
      instance_name           = optional(string)       # Name of the database instance
      name                    = optional(string)       # Database name
      user                    = optional(string)       # Database user
      credentials_secret      = optional(string)       # Kubernetes secret that stores the database credentials
      iops                    = optional(number)       # Provisioned IOPS for the database
      major_version           = optional(string)       # Major version of the database
      storage                 = optional(string)       # Storage size for the database
      storage_type            = optional(string)       # Storage type for the database
      storage_throughput      = optional(number)       # Storage throughput for the database
      multi_az                = optional(bool)         # Multi-AZ deployment for the database
      deletion_protection     = optional(bool)         # Deletion protection for the database
      skip_final_snapshot     = optional(bool)         # Skip final snapshot for the database
      maintenance_window      = optional(string)       # Maintenance window for the database
      backup_window           = optional(string)       # Backup window for the database
      backup_retention_period = optional(number)       # Backup retention period for the database
      vpc_id                  = optional(string)       # VPC ID for the database
      subnet_ids              = optional(list(string)) # List of subnet IDs for the database. Private subnets are recommended
      existing_endpoint       = optional(string)       # Existing database endpoint to use instead of creating a new one
    }))
  })
}

variable "ingestion" {
  description = "Ingestiopn pods settings"
  type = object({
    image = optional(object({
      repository   = optional(string) # Docker image repository
      tag          = optional(string) # Docker image tag
      pull_secrets = optional(string) # Docker image pull secret
    }))
    extra_envs         = optional(string)       # Extra environment variables for the pods, as `[key1:value1,key2:value2,...]`
    pod_annotations    = optional(map(string))  # Annotations for the pods
    extra_policies_arn = optional(list(string)) # List of IAM policy ARNs to be attached to the ingestion pods' IAM role
  })
  default = null
}
