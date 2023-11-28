# # Postgres Resource
# module "rds_argo_workflows" {
#   source        = "git@github.com:open-metadata/terraform-rds-instance.git?ref=v0.1.3"
#   instance_name = "rds-argo-workflows"
#   db_name       = "argowf"
#   region        = var.region

#   vpc_id     = var.vpc_id
#   subnet_ids = data.aws_subnets.private.ids
#   db_engine  = "postgres"
#   db_version = "15"

#   allow_from_sgs = flatten([for config in data.aws_eks_cluster.eks.vpc_config : config.security_group_ids])
# }