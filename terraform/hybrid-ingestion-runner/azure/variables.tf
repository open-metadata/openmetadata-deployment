variable "aks_resource_group_name" {
  type        = string
  description = "Name of the resource group containing the AKS cluster."
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the existing AKS cluster."
}

variable "subscription_id" {
  type        = string
  default     = null
  description = "Azure subscription ID (optional)."
}

variable "tenant_id" {
  type        = string
  default     = null
  description = "Azure AD tenant ID (optional)."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure region where the resources will be deployed."
}

variable "release_version" {
  type        = string
  description = "The Hybrid Ingestion Runner version to deploy."
  default     = "1.11.7"
}

variable "namespace" {
  type        = string
  default     = "collate-runner"
  description = "The application's namespace prefix. Note that `var.environment` will be appended to this value."
}

variable "environment" {
  type        = string
  description = "The environment name where the resources will be deployed."
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

variable "ECR_ACCESS_KEY" {
  type        = string
  description = "The Access key shared by Collate to pull Docker images from ECR."
}

variable "ECR_SECRET_KEY" {
  type        = string
  description = "The Secret Key shared by Collate to pull Docker images from ECR."
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Azure Key Vault to retrieve for stored credentials."
  default     = null
}

variable "key_vault_resource_group_name" {
  type        = string
  description = "The resource group name where the Azure Key Vault is located."
  default     = null
}

variable "argowf" {
  description = "Argo Workflows configuration."
  type = object({
    provisioner = optional(string)
    endpoint    = optional(string)
  })
  default = {
    provisioner = "helm"
  }
}

variable "ingestion" {
  description = "Ingestion pods helm configurations."
  type = object({
    image = optional(object({
      repository   = optional(string)
      tag          = optional(string)
      pull_secrets = optional(string)
    }))
    extra_envs      = optional(string)
    pod_annotations = optional(map(string))
  })
  default = null
}
