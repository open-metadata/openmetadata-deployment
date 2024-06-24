variable "subscription_id" {
  type        = string
  description = "The Subscription Id for the Azure Account."
}

variable "resource_group_name" {
  type        = string
  description = "The Name of Azure Resource Group for Storage Account and AKS."
}

variable "azure_location" {
  type = string
}

variable "argo_azure_artifact_name" {
  type        = string
  description = "Name of Azure Storage Account to be used for Argo Workflows."
}

variable "aks_name" {
  type = string
}

variable "application_namespace" {
  type        = string
  description = "The Namespace in AKS where Collate will spin up Argo Workflows for Ingestion."
}

variable "argo_namespace" {
  type        = string
  description = "The Namespace in AKS where ArgoWorkflows are installed."
}

variable "argo_server_service_account_name" {
  type        = string
  description = "Service Account Name for Argo Workflows Server Pod."
}

variable "argo_controller_service_account_name" {
  type        = string
  description = "Service Account Name for Argo Workflows Controller Pod."
}

variable "application_service_account_name" {
  type        = string
  description = "The Service Account Name that will be used by Collate Ingestion."
}

variable "container_name" {
  type        = string
  description = "The name of the Azure Storage Container within the Storage Account."
}