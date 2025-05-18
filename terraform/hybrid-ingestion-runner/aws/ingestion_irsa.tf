locals {
  # https://github.com/open-metadata/hybrid-ingestion-runner-helm-chart/blob/main/charts/hybrid-ingestion-runner/values.yaml#L34
  ingestion_sa_name      = "ingestion"
  secrets_manager_region = var.region
  create_irsa            = var.ingestion_identity_mode == "irsa"
  create_pod_identity    = var.ingestion_identity_mode == "pod_identity"
}

data "aws_iam_policy_document" "ingestion_pods" {
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
      "s3:PutObject"
    ]

    resources = ["${module.s3_bucket.s3_bucket_arn}/workflows/*"]
  }
  statement {
    sid = "SecretsManager"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets"
    ]

    resources = ["arn:aws:secretsmanager:${local.secrets_manager_region}:${data.aws_caller_identity.current.account_id}:secret:${var.secrets_manager_path}/*"]
  }

}

resource "aws_iam_policy" "ingestion_pods" {
  name   = "ingestion-pods-${var.region}-${var.environment}"
  policy = data.aws_iam_policy_document.ingestion_pods.json
}

module "ingestion_pods_irsa" {
  source   = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version  = "~> 5.55"
  for_each = toset(local.create_irsa ? ["this"] : [])

  role_name = "ingestion-pods-${var.region}-${var.environment}"
  role_policy_arns = {
    s3rw = aws_iam_policy.ingestion_pods.arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${local.namespace}:${local.ingestion_sa_name}"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ingestion_pods_extra" {
  for_each = var.ingestion_identity_mode == "irsa" ? toset(coalesce(try(var.ingestion.extra_policies_arn, null), [])) : {}

  role       = module.ingestion_pods_irsa["this"].iam_role_name
  policy_arn = each.value
}

data "aws_iam_policy_document" "ingestion_pods_pod_identity_assume_role" {
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

resource "aws_iam_role" "ingestion_pods_pod_identity" {
  count              = local.create_pod_identity ? 1 : 0
  name               = "ingestion-pods-${var.region}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ingestion_pods_pod_identity_assume_role[0].json
}

resource "aws_iam_role_policy_attachment" "ingestion_pods_pod_identity" {
  count      = local.create_pod_identity ? 1 : 0
  role       = aws_iam_role.ingestion_pods_pod_identity[0].name
  policy_arn = aws_iam_policy.ingestion_pods.arn
}

resource "aws_iam_role_policy_attachment" "ingestion_pods_extra_pod_identity" {
  count      = local.create_pod_identity ? length(coalesce(try(var.ingestion.extra_policies_arn, null), [])) : 0
  role       = aws_iam_role.ingestion_pods_pod_identity[0].name
  policy_arn = var.ingestion.extra_policies_arn[count.index]
}
