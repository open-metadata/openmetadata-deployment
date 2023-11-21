

# data "aws_iam_policy_document" "opensearch" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions   = ["es:*"]
#     resources = ["*"]
#   }
# }

# resource "aws_opensearch_domain" "opensearch" {
#   domain_name    = var.os_name
#   engine_version = "OpenSearch_2.7"

#   cluster_config {
#     instance_type            = "t3.small.search"
#     dedicated_master_enabled = false
#     instance_count           = 2
#     zone_awareness_enabled   = true
#     zone_awareness_config {
#       availability_zone_count = 2
#     }
#   }

#   advanced_security_options {
#     enabled                        = true
#     internal_user_database_enabled = true
#     master_user_options {
#       master_user_name     = "admin"
#       master_user_password = random_password.opensearch_master_sandbox.result
#     }
#   }

#   ebs_options {
#     ebs_enabled = true
#     volume_size = "30"
#   }

#   encrypt_at_rest {
#     enabled = true
#   }

#   node_to_node_encryption {
#     enabled = true
#   }

#   vpc_options {
#     subnet_ids         = data.aws_subnets.applications_internal.ids
#     security_group_ids = [aws_security_group.opensearch_sandbox.id]
#   }

#   domain_endpoint_options {
#     enforce_https       = true
#     tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
#   }


#   access_policies = data.aws_iam_policy_document.opensearch.json

#   tags = {
#     Domain = "sandbox"
#   }
# }

# ## Security
# resource "aws_security_group" "opensearch_sandbox" {
#   name        = "sandbox-opensearch"
#   description = "Private OpenSearch instance for sandbox"
#   vpc_id      = data.aws_vpc.applications.id

#   ingress {
#     from_port = 443
#     to_port   = 443
#     protocol  = "tcp"

#     security_groups = [data.aws_security_group.nodes.id]
#   }
# }


# ## Credentials
# resource "random_password" "opensearch_master_sandbox" {
#   length      = 16
#   min_upper   = 1
#   min_lower   = 1
#   min_numeric = 1
#   min_special = 1
#   special     = true
# }

# resource "aws_ssm_parameter" "opensearch_master_pass" {
#   name  = "/applications/sandbox/elasticsearch/password"
#   type  = "SecureString"
#   value = random_password.opensearch_master_sandbox.result
# }
# resource "aws_ssm_parameter" "opensearch_master_user" {
#   name  = "/applications/sandbox/elasticsearch/user"
#   type  = "SecureString"
#   value = "om-sandbox"
# }
# resource "aws_ssm_parameter" "opensearch_endpoint" {
#   name  = "/applications/sandbox/elasticsearch/endpoint"
#   type  = "SecureString"
#   value = aws_opensearch_domain.sandbox.endpoint
# }

# ## App Config
# resource "kubernetes_manifest" "elasticsearch_config_secret_sandbox" {
#   manifest = {
#     "apiVersion" = "external-secrets.io/v1beta1"
#     "kind"       = "ExternalSecret"
#     "metadata" = {
#       "name"      = "om-elasticsearch-config"
#       "namespace" = "sandbox"
#     }
#     "spec" = {
#       secretStoreRef = module.eso_secret_store_main.secret_store_ref
#       target = {
#         name = "om-elasticsearch-config"
#         template = {
#           data = {
#             ELASTICSEARCH_USER     = "{{ .user }}"
#             ELASTICSEARCH_PASSWORD = "{{ .password }}"
#             ELASTICSEARCH_HOST     = "{{ .endpoint }}"
#             ELASTICSEARCH_PORT     = "443"
#             ELASTICSEARCH_SCHEME   = "https"
#             SEARCH_TYPE            = "opensearch"
#           }
#         }
#       }
#       data = [
#         {
#           secretKey = "user"
#           remoteRef = {
#             key = "/applications/sandbox/elasticsearch/user"
#           }
#         },
#         {
#           secretKey = "password"
#           remoteRef = {
#             key = "/applications/sandbox/elasticsearch/password"
#           }
#         },
#         {
#           secretKey = "endpoint"
#           remoteRef = {
#             key = "/applications/sandbox/elasticsearch/endpoint"
#           }
#         }
#       ]
#     }
#   }
# }
