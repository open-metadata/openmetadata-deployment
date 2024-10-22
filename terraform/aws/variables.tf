variable "eks_cluster" {
  type        = string
  description = "Name of the EKS cluster where OpenMetadata will be deployed."
}

variable "eks_nodes_sg_ids" {
  type        = list(string)
  description = "List of security group IDs attached to the EKS nodes. Used to allow traffic from the OpenMetadata application to the databases."
  default     = []
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified."
  default     = null
}

variable "region" {
  type        = string
  description = "AWS region name, for example:`us-east-2`."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets IDs where the databases and OpenSearch will be deployed. The recommended configuration is to use private subnets."
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy the databases and OpenSearch. For example: `vpc-xxxxxxxx`."
}


# OpenMetadata application

variable "app_namespace" {
  type        = string
  default     = "openmetadata"
  description = "Namespace to deploy the OpenMetadata application."
}

variable "docker_image_name" {
  type        = string
  default     = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-eu-west-1"
  description = "Full path of the server Docker image name, excluding the tag."
}

variable "docker_image_tag" {
  type        = string
  default     = "om-1.5.7-cl-1.5.7"
  description = "Docker image tag for both the server and ingestion."
}

variable "ingestion_image_name" {
  type        = string
  default     = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1"
  description = "Full path of the ingestion Docker image name, excluding the tag."
}

variable "ECR_ACCESS_KEY" {
  type        = string
  description = "The Access key shared by Collate to pull Docker images from ECR."
}

variable "ECR_SECRET_KEY" {
  type        = string
  description = "The Secret Key shared by Collate to pull Docker images from ECR."
}


# OpenMetadata database

variable "db_instance_name" {
  type        = string
  default     = "openmetadata"
  description = "Name of the OpenMetadata database instance."
}

variable "db_instance_class" {
  type        = string
  description = "OpenMetadata database instance type."
  default     = "db.m7g.large"
}

variable "db_storage" {
  type        = string
  description = "OpenMetadata database storage size."
  default     = 100
}

variable "db_major_version" {
  type        = string
  description = "OpenMetadata database major version. For PostgreSQL, must be a string representing a version between '12' and '16', inclusive."
  default     = "16"

  validation {
    condition     = contains(["12", "13", "14", "15", "16"], var.db_major_version)
    error_message = "Invalid PostgreSQL version. The version must be '12', '13', '14', '15', or '16'"
  }
}

variable "db_parameters" {
  type        = list(map(string))
  default     = []
  description = "List of parameters to use in the OpenMetadata database parameter group."
}


# Argo Workflows database

variable "argowf_db_instance_name" {
  type        = string
  default     = "argowf"
  description = "Name of the Argo Workflows database instance."
}

variable "argowf_db_instance_class" {
  type        = string
  description = "Argo Workflows database instance type."
  default     = "db.t4g.micro"
}

variable "argowf_db_storage" {
  type        = string
  description = "Argo Workflows database storage size."
  default     = 10
}

variable "argowf_db_major_version" {
  type        = string
  description = "Argo Workflows database major version. For PostgreSQL, must be a string representing a version between '12' and '16', inclusive."
  default     = "16"

  validation {
    condition     = contains(["12", "13", "14", "15", "16"], var.argowf_db_major_version)
    error_message = "Invalid PostgreSQL version. The version must be '12', '13', '14', '15', or '16'"
  }
}


# S3 Bucket

variable "s3_bucket_name" {
  type        = string
  description = "The name of S3 bucket for storing the Argo Workflows logs and OpenMetadata assets."
  default     = null
}


# Search engine (OpenSearch)

variable "opensearch_name" {
  type        = string
  description = "The OpenSearch domain name."
  default     = "openmetadata"
}
