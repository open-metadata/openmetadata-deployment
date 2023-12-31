# IAM policy
data "aws_iam_policy_document" "opensearch" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["es:*"]
    resources = ["*"]
  }
}

# OpenSearch Resource
resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.opensearch_name
  engine_version = "OpenSearch_2.7"

  cluster_config {
    instance_type            = "t3.small.search"
    dedicated_master_enabled = false
    instance_count           = 2
    zone_awareness_enabled   = true
    zone_awareness_config {
      availability_zone_count = 2
    }
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = "admin"
      master_user_password = random_password.opensearch_password.result
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = "30"
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids         = var.subnet_ids
    security_group_ids = [module.opensearch_sg.security_group_id]
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }


  access_policies = data.aws_iam_policy_document.opensearch.json

}

## Security
module "opensearch_sg" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "~>5.1"
  create             = true
  name               = "${var.opensearch_name}-opensearch"
  description        = "Security group for OpenMetadata opensearch"
  vpc_id             = var.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  ingress_with_source_security_group_id = [for sg_id in var.eks_nodes_sg_ids :
    {
      from_port                = "443"
      to_port                  = "443"
      protocol                 = "tcp"
      description              = "DB from ${sg_id}"
      source_security_group_id = sg_id
    }
  ]
}

# ## Credentials
resource "random_password" "opensearch_password" {
  length      = 16
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

#secret
resource "kubernetes_secret" "opensearch_secret" {
  metadata {
    name      = "opensearch-secret"
    namespace = kubernetes_namespace.argowf.id
  }

  data = {
    master-password = base64encode(random_password.opensearch_password.result)
  }
}
