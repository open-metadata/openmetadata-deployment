# variable "eks_cluster" {
#   type        = string
#   description = "Provide the name of EKS cluster"
#   default = "mgmt"
# }
variable "region" {
  type        = string
  description = "Provide the region name for example:`us-east-2` "
  default     = "us-east-2"
}
variable "vpc_id" {
  type        = string
  description = "Provide the VPC ID for example: `vpc-xxxxxxxxxx`"
  default     = "vpc-0bbeea66d3e68d55f"
}
variable "ACCESS_KEY" {
  type        = string
  description = "Provide the Access Key"
}
variable "SECRET_KEY" {
  type        = string
  description = "Provide the Secret Key"
}