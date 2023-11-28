# data "aws_eks_cluster" "eks" {
#   name = var.eks_cluster
# }

data "aws_vpc" "get_vpc" {
  id = var.vpc_id
}
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "Private"
  }
}
# locals {
#   docker_password_file_path = "/Users/dhruvinmaniar/Desktop/dhruvinmaniar123/openmetadata-deployment/pwd.txt"  # Replace with the actual path to your Docker password file
# }

# data "local_file" "docker_password" {
#   filename = local.docker_password_file_path
# }