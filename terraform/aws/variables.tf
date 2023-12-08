variable "eks_cluster" {
  type        = string
  description = "Provide the name of EKS cluster"
}
variable "region" {
  type        = string
  description = "Provide the region name for example:`us-east-2` "
}
variable "vpc_id" {
  type        = string
  description = "Provide the VPC ID for example: `vpc-xxxxxxxxxx`"
}
variable "ECR_ACCESS_KEY" {
  type        = string
  description = "Provide the Access key shared from Collate to pull docker images"
}
variable "ECR_SECRET_KEY" {
  type        = string
  description = "Provide the Secret Key shared from Collate to pull docker images"
}
variable "opensearch_name" {
  type        = string
  description = "Provide the OpenSearch Instance name"
}
variable "imageTag" {
  type        = string
  description = "Provide the Openmetadata application image tag in a specific format like `om-1.2.2-cl-1.2.2`"
}
variable "DOCKER_SECRET_NAME" {
  type        = string
  description = "Provide the name of secret to be created for authentication in aws"
  default     = "ecr-registry-creds"
}
variable "argoIngestionImage" {
  type        = string
  description = "Provide the name of ingestion image for Openmetadata in the format like `118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1:om-1.2.2-cl-1.2.2` "
}
/* RDS VARIABLES */
variable "instance_name" {
  type        = string
  description = "Name of the RDS instance"
  default     = "rds-argo-workflows"
}
variable "db_name" {
  type        = string
  description = "Name of the initial database for RDS instance"
  default     = "argowf"
}
variable "admin_name" {
  type        = string
  description = "Name of the database admin user"
  default     = "root"
}

variable "db_engine" {
  type        = string
  description = "DB engine"
  default     = "postgres"
}

variable "major_engine_version" {
  type        = string
  description = "DB major version"
  default     = "15"
}

variable "db_instance_class" {
  type        = string
  description = "DB instance type"
  default     = "db.t4g.micro"
}

variable "db_storage" {
  type        = string
  description = "DB storage capacity"
  default     = 10
}

variable "apply_rds_changes_immediately" {
  type        = bool
  default     = false
  description = "Whether to apply RDS changes immediately. Otherwise it will be scheduled during db_maintenance_window"
}

variable "allow_from_sgs" {
  type        = list(string)
  description = "Allow access from these security group ids"
  default     = []
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key to encrypt db and backups. Default will be used if not provided"
  default     = null
}

variable "snapshot_retention" {
  type        = number
  description = "Number of days to retain the DB backup"
  default     = 30
}

variable "multi_az" {
  type        = bool
  description = "Deploy the database in multiple availability zones"
  default     = true
}

variable "alarm_sns_topic" {
  type        = string
  description = "SNS Topic Name for CloudWatch Alarms"
  default     = "sns-admin-prod"
}

variable "parameter_group_name" {
  type        = string
  description = "Provide the name of RDS Parameter group by client"
  default     = "saas-collate"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
  default     = {}
}

variable "instance_tags" {
  type        = map(string)
  description = "Tags to apply to the instance"
  default     = {}
}

variable "parameters" {
  type = list(map(string))
  default = [
    {
      name  = "sort_buffer_size"
      value = "4194304"
    }
  ]
  description = "Parameters to pass to the DB parameter group"
}


/* S3 Bucket */
variable "bucket_name" {
  type        = string
  description = "Provide the name of bucket for storing the argoworkflow logs"
  default     = "argo-workflow-log"
}
