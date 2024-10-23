data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "eks" {
  name = var.eks_cluster
}

data "aws_iam_openid_connect_provider" "oidc" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

