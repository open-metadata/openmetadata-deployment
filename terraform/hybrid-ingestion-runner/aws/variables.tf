variable "eks_cluster" {
  type        = string
  description = "Name of the EKS cluster where the resources will be deployed."
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
  default     = "1.11.6"
}

variable "namespace" {
  type        = string
  default     = "collate-runner"
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
    provisioner = optional(string) # Provisioner for the Argo Workflows controller. Options: `helm` or `existing`
    endpoint    = optional(string) # Endpoint for the Argo Workflows server. Only used if `provisioner` is `existing`
  })
  default = {
    provisioner = "helm"
  }
}

variable "ingestion" {
  description = "Ingestiopn pods settings"
  type = object({
    image = optional(object({
      repository   = optional(string) # Docker image repository
      tag          = optional(string) # Docker image tag
      pull_secrets = optional(string) # Docker image pull secret
    }))
    extra_envs              = optional(string)       # Extra environment variables for the pods, as `[key1:value1,key2:value2,...]`
    pod_annotations         = optional(map(string))  # Annotations for the pods
    extra_policies_arn      = optional(list(string)) # List of IAM policy ARNs to be attached to the ingestion pods' IAM role
    ignore_version_validate = optional(bool)         # Whether to ignore version validation between the Helm chart and the Docker image
  })
  default = null
}
