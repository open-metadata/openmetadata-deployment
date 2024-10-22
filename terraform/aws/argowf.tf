locals {
  argo = {
    namespace          = "argowf"
    controller_sa_name = "argo-workflows-controller-sa"
    server_sa_name     = "argo-workflows-server-sa"
    jobs_sa_name       = "om-role"
    db_name            = "argowf"
    db_user            = "dbadmin"
    db_creds_secret    = "argowf-db"
  }
}

# Argo Workflows resources

resource "kubernetes_namespace" "argowf" {
  metadata {
    annotations = {
      name = local.argo.namespace
    }
    name = local.argo.namespace
  }
}

resource "helm_release" "argowf" {
  name       = "argowf"
  namespace  = local.argo.namespace
  chart      = "argo-workflows"
  version    = "0.40.8"
  repository = "https://argoproj.github.io/argo-helm"
  values = [
    templatefile("${path.module}/helm-dependencies/argowf_config.tftpl",
      {
        controllerSaName   = local.argo.controller_sa_name
        serverSaName       = local.argo.server_sa_name
        s3_bucket_name     = local.default_bucket_name
        region             = var.region
        db_host            = module.rds_argo_workflows.db_instance_endpoint
        db_name            = local.argo.db_name
        db_creds_secret    = local.argo.db_creds_secret
        controller_iam_arn = module.irsa_role_argowf_controller.iam_role_arn
        server_iam_arn     = module.irsa_role_argowf_server.iam_role_arn
    })
  ]
}


# Database resources (Postgres)

resource "random_password" "argowf_db_password" {
  length           = 16
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

module "rds_argo_workflows" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~>6.10"

  identifier                  = var.argowf_db_instance_name
  db_name                     = local.argo.db_name
  username                    = local.argo.db_user
  password                    = random_password.argowf_db_password.result
  manage_master_user_password = false
  # manage_master_user_password = true
  # master_user_secret_kms_key_id = var.kms_key_id

  engine               = "postgres"
  family               = "postgres${var.argowf_db_major_version}"
  major_engine_version = var.argowf_db_major_version
  instance_class       = var.argowf_db_instance_class

  allocated_storage     = var.argowf_db_storage
  storage_encrypted     = true
  kms_key_id            = var.kms_key_id
  copy_tags_to_snapshot = true
  apply_immediately     = true

  iam_database_authentication_enabled = true
  multi_az                            = false

  maintenance_window      = "Sat:02:00-Sat:03:00"
  backup_window           = "03:00-04:00"
  backup_retention_period = 30

  # Network
  port                   = "5432"
  vpc_security_group_ids = [module.sg_argo_db.security_group_id]
  create_db_subnet_group = true
  subnet_ids             = var.subnet_ids

  # Database Deletion Protection
  deletion_protection = true
}

module "sg_argo_db" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "~>5.1"
  create             = true
  name               = "${var.argowf_db_instance_name}-db"
  description        = "Security group for Argo Workflows db"
  vpc_id             = var.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  ingress_with_source_security_group_id = [for sg_id in var.eks_nodes_sg_ids :
    {
      from_port                = "5432"
      to_port                  = "5432"
      protocol                 = "tcp"
      description              = "DB from ${sg_id}"
      source_security_group_id = sg_id
    }
  ]
}

resource "kubernetes_secret" "argowf_db_creds" {
  metadata {
    name      = local.argo.db_creds_secret
    namespace = kubernetes_namespace.argowf.id
  }
  data = {
    username = local.argo.db_user
    password = random_password.argowf_db_password.result
  }
}
