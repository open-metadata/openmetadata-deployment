resource "aws_iam_role" "ecr_registry_helper_role" {
  name = "ecr-registry-helper-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecr.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ecr_registry_helper_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.ecr_registry_helper_role.name
}

# resource "aws_ecr" "ecr_registry" {
#   name = "my-ecr-repository"
# }

resource "kubernetes_secret" "ecr_registry_helper_k8s_secret" {
  metadata {
    name      = "ecr-registry-helper-secrets"
    namespace = kubernetes_namespace.argowf.id
  }

  data = {}
}

resource "kubernetes_config_map" "ecr_registry_helper_k8s_config_map" {
  metadata {
    name      = "ecr-registry-helper-cm"
    namespace = "default"
  }

  data = {
    AWS_REGION         = "eu-west-1" # Replace with your ECR region
    DOCKER_SECRET_NAME = "regcred"   # Replace with your desired ECR token secret name
  }
}

resource "kubernetes_service_account" "ecr_registry_helper_k8s_service_account" {
  metadata {
    name      = "ecr-auth-sa"
    namespace = kubernetes_namespace.argowf.id
  }
}
