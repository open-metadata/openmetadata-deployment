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
  description = "Provide the VPC ID for example: `vpc-xxxxxxxxxx` "
}
variable "ecr_auth_token" {
  type        = string
  description = "Provide the ecr auth token"
} 
variable "opensearch_name" {
  type = string
  description = "Provide the name of opensearch to create"
}