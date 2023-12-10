resource "aws_iam_role" "admin_role" {
  name = "iam-argowf-${var.region}-admin"

  assume_role_policy = data.aws_iam_policy_document.admin_role_policy.json
}

data "aws_iam_policy_document" "admin_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    # Only for users with MFA
    # condition {
    #   test     = "Bool"
    #   variable = "aws:MultiFactorAuthPresent"
    #   values   = ["true"]
    # }
  }
}