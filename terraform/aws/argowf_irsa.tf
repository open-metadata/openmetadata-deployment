# Server IAM policy
data "aws_iam_policy_document" "argowf_server" {
  statement {
    sid = "ListBuckets"

    actions = [
      "s3:ListBucket"
    ]

    resources = [module.s3_bucket.s3_bucket_arn]
  }
  statement {
    sid     = "S3RO"
    actions = ["s3:GetObject"]

    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]
  }
}

resource "aws_iam_policy" "argowf_server" {
  name   = "argowf-server-${var.region}"
  policy = data.aws_iam_policy_document.argowf_server.json
}

module "irsa_role_argowf_server" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.22"

  role_name        = "argowf-server-${var.region}"
  role_policy_arns = { "S3RO" = aws_iam_policy.argowf_server.arn }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
      namespace_service_accounts = ["${local.argo.namespace}:${local.argo.server_sa_name}"]
    }
  }
}

# Argo Workflows Controller

data "aws_iam_policy_document" "argowf_controller" {
  statement {
    sid = "ListBuckets"

    actions = [
      "s3:ListBucket"
    ]

    resources = [module.s3_bucket.s3_bucket_arn]
  }
  statement {
    sid = "S3RW"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]
  }
}

resource "aws_iam_policy" "argowf_controller" {
  name   = "argowf-controller-${var.region}"
  policy = data.aws_iam_policy_document.argowf_controller.json
}

module "irsa_role_argowf_controller" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.22"

  role_name = "argowf-controller-${var.region}"
  role_policy_arns = {
    s3rw = aws_iam_policy.argowf_controller.arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
      namespace_service_accounts = ["${local.argo.namespace}:${local.argo.controller_sa_name}"]
    }
  }
}
