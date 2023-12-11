variable "eks_cluster" {
  type        = string
  description = "Name of EKS cluster"
}
variable "region" {
  type        = string
  description = "AWS region name, for example:`us-east-2` "
}

##
## Shared resources
##

variable "kms_key_id" {
  type        = string
  description = "KMS Key to encrypt db and backups. Default will be used if not provided"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy databases and elasticsearch. For example: `vpc-xxxxxxxxxx`"
}

variable "eks_nodes_sg_ids" {
  type        = list(string)
  description = "Allow access from these security group ids to databases"
  default     = []
}
variable "subnet_ids" {
  type        = list(string)
  description = "Create databases in these subnets"
  default     = []
}


##
## Argo Workflows
##
variable "argowf_db_instance_name" {
  type        = string
  default     = "argowf"
  description = "Name of the ArgoWf DB instance"
}

variable "argowf_db_major_version" {
  type        = string
  description = "ArgoWf DB major version"
  default     = "15"
}

variable "argowf_db_instance_class" {
  type        = string
  description = "ArgoWf DB instance type"
  default     = "db.t4g.micro"
}

variable "argowf_db_storage" {
  type        = string
  description = "ArgoWf DB storage size"
  default     = 10
}
variable "argowf_bucket_name" {
  type        = string
  description = "Provide the name of bucket for storing the argoworkflow logs"
  default     = "argo-workflow-log"
}

##
## Application
##
variable "app_namespace" {
  type        = string
  default     = "openmetadata"
  description = "Namespace to deploy the OpenMetadata application"
}
variable "docker_image_name" {
  type        = string
  default     = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-eu-west-1"
  description = "Full path of the image name, excluding tag"
}
variable "docker_image_tag" {
  type        = string
  default     = ""
  description = "Image tag for both the server and ingestion. Leave empty for default"
}
variable "ingestion_image_name" {
  type        = string
  default     = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1"
  description = "Full path of the ingestion image name, excluding tag"
}
variable "ECR_ACCESS_KEY" {
  type        = string
  description = "Provide the Access key shared from Collate to pull docker images"
}
variable "ECR_SECRET_KEY" {
  type        = string
  description = "Provide the Secret Key shared from Collate to pull docker images"
}

##
## Application database
##

variable "db_instance_name" {
  type        = string
  default     = "openmetadata"
  description = "Name of the OpenMetadata DB instance"
}

variable "db_major_version" {
  type        = string
  description = "OpenMetadata DB major version"
  default     = "15"
}

variable "db_instance_class" {
  type        = string
  description = "OpenMetadata DB instance type"
  default     = "db.m7g.xlarge"
}

variable "db_storage" {
  type        = string
  description = "OpenMetadata DB storage size"
  default     = 120
}

variable "db_parameters" {
  type = list(map(string))
  default = [
    {
      name  = "sort_buffer_size"
      value = "4194304"
    }
  ]
  description = "Parameters to pass to the DB parameter group"
}

##
## S3 Bucket
##


##
## ElasticSearch / OpenSearch
##
variable "opensearch_name" {
  type        = string
  description = "Provide the OpenSearch Instance name"
  default     = "openmetadata"
}
