locals {
  # https://github.com/open-metadata/hybrid-ingestion-runner-helm-chart/blob/main/charts/hybrid-ingestion-runner/values.yaml#L34
  ingestion_sa_name = "ingestion"
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
}

resource "aws_iam_policy" "ingestion_pods" {
  name   = "ingestion-pods-${var.region}"
  policy = data.aws_iam_policy_document.ingestion_pods.json
}

module "ingestion_pods_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.55"

  role_name = "ingestion-pods-${var.region}"
  role_policy_arns = {
    s3rw = aws_iam_policy.ingestion_pods.arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${var.namespace}:${local.ingestion_sa_name}"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ingestion_pods_extra" {
  for_each = toset(coalesce(try(var.ingestion.extra_policies_arn, null), []))

  role       = module.ingestion_pods_irsa.iam_role_name
  policy_arn = each.value
}
