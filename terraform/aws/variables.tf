variable "eks_cluster" {
  type        = string
  default     = "mgmt"
  description = "Provide the name of EKS cluster"
}
variable "region" {
  type    = string
  default = "us-east-2"
}
variable "vpc_id" {
  type    = string
  default = "vpc-0bbeea66d3e68d55f"
}