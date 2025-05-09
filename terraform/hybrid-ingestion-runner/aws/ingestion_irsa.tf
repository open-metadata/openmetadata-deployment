locals {
  # https://github.com/open-metadata/hybrid-ingestion-runner-helm-chart/blob/main/charts/hybrid-ingestion-runner/values.yaml#L34
  ingestion_sa_name      = "ingestion"
  secrets_manager_region = var.region
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
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.55"

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
  for_each = toset(coalesce(try(var.ingestion.extra_policies_arn, null), []))

  role       = module.ingestion_pods_irsa.iam_role_name
  policy_arn = each.value
}
