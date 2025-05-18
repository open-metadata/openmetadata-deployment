# Argo Workflows Server

locals {
  create_irsa         = var.argowf_identity_mode == "irsa" && local.argowf_provisioner == "helm"
  create_pod_identity = var.argowf_identity_mode == "pod_identity" && local.argowf_provisioner == "helm"
}

data "aws_iam_policy_document" "argowf_server" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

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

    resources = ["${module.s3_bucket.s3_bucket_arn}/workflows/*"]
  }
}

resource "aws_iam_policy" "argowf_server" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  name   = "argowf-server-${var.region}-${var.environment}"
  policy = data.aws_iam_policy_document.argowf_server["this"].json
}

module "irsa_role_argowf_server" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.22"

  for_each = toset(local.create_irsa ? ["this"] : [])

  role_name        = "argowf-server-${var.region}-${var.environment}"
  role_policy_arns = { "S3RO" = aws_iam_policy.argowf_server["this"].arn }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${local.argowf.namespace}:${local.argowf.server_sa_name}"]
    }
  }
}


# Argo Workflows Controller

data "aws_iam_policy_document" "argowf_controller" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  statement {
    sid = "ListBuckets"

    actions = [
      "s3:ListBucket"
    ]

    resources = [module.s3_bucket.s3_bucket_arn]
  }
  statement {
    sid = "GetObject"
    actions = [
      "s3:GetObject"
    ]
    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]
  }
  statement {
    sid = "S3RW"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    resources = ["${module.s3_bucket.s3_bucket_arn}/workflows/*"]
  }
}

resource "aws_iam_policy" "argowf_controller" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  name   = "argowf-controller-${var.region}-${var.environment}"
  policy = data.aws_iam_policy_document.argowf_controller["this"].json
}

module "irsa_role_argowf_controller" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.22"

  for_each = toset(local.create_irsa ? ["this"] : [])

  role_name = "argowf-controller-${var.region}-${var.environment}"
  role_policy_arns = {
    s3rw = aws_iam_policy.argowf_controller["this"].arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${local.argowf.namespace}:${local.argowf.controller_sa_name}"]
    }
  }
}

# Pod Identity roles for Argo Workflows Server
data "aws_iam_policy_document" "argowf_server_pod_identity_assume_role" {
  count = local.create_pod_identity ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [data.aws_eks_cluster.eks.id]
    }
  }
}

resource "aws_iam_role" "argowf_server_pod_identity" {
  count              = local.create_pod_identity ? 1 : 0
  name               = "argowf-server-${var.region}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.argowf_server_pod_identity_assume_role[0].json
}

resource "aws_iam_role_policy_attachment" "argowf_server_pod_identity" {
  count      = local.create_pod_identity ? 1 : 0
  role       = aws_iam_role.argowf_server_pod_identity[0].name
  policy_arn = aws_iam_policy.argowf_server["this"].arn
}

# Pod Identity roles for Argo Workflows Controller
data "aws_iam_policy_document" "argowf_controller_pod_identity_assume_role" {
  count = local.create_pod_identity ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [data.aws_eks_cluster.eks.id]
    }
  }
}

resource "aws_iam_role" "argowf_controller_pod_identity" {
  count              = local.create_pod_identity ? 1 : 0
  name               = "argowf-controller-${var.region}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.argowf_controller_pod_identity_assume_role[0].json
}

resource "aws_iam_role_policy_attachment" "argowf_controller_pod_identity" {
  count      = local.create_pod_identity ? 1 : 0
  role       = aws_iam_role.argowf_controller_pod_identity[0].name
  policy_arn = aws_iam_policy.argowf_controller["this"].arn
}
