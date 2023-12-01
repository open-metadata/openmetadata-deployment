data "aws_eks_cluster" "eks" {
  name = var.eks_cluster
}
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
