# OpenMetadata Server IAM role for Service Account (openmetadata-server)

data "aws_iam_policy_document" "server" {
  statement {
    sid = "AllowBedrockInvokeModel"
    actions = [
      "bedrock:InvokeModel*"
    ]
    resources = [
      "arn:aws:bedrock:*::foundation-model/*",
      "arn:aws:bedrock:*:*:inference-profile/*"
    ]
  }
}

resource "aws_iam_policy" "server" {
  name   = "openmetadata-server-${var.region}"
  policy = var.caip_enabled ? data.aws_iam_policy_document.server.json : "{}"
}

module "irsa_role_server" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.60"

  role_name = "openmetadata-server-${var.region}"
  role_policy_arns = {
    server = aws_iam_policy.server.arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${var.app_namespace}:${local.omd.server_sa_name}"]
    }
  }
}
