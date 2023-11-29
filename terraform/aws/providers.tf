provider "aws" {
  region  = var.region
  profile = "terraform-humans-prod"
}

# data "aws_eks_cluster_auth" "this" {
#   name = module.eks.cluster_name
# }

provider "kubernetes" {
  # host = data.aws_eks_cluster.eks.endpoint
  # #token                  = data.aws_eks_cluster_auth.this.token
  # cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   args        = ["eks", "get-token", "--cluster-name", var.eks_cluster, "--profile", "terraform-humans-prod"]
  #   command     = "aws"
  # }
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

provider "helm" {
  kubernetes {
    # host                   = data.aws_eks_cluster.eks.endpoint
    # cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   args        = ["eks", "get-token", "--cluster-name", var.eks_cluster, "--profile", "terraform-humans-prod"]
    #   command     = "aws"
    # }
    config_path    = "~/.kube/config"
    config_context = "docker-desktop"
  }
}
