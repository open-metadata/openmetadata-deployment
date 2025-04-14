# Argo Workflows resources

resource "kubernetes_namespace" "argowf" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  metadata {
    annotations = {
      name = local.argowf.namespace
    }
    name = local.argowf.namespace
  }
}

resource "helm_release" "argowf" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  name       = "argowf"
  namespace  = kubernetes_namespace.argowf["this"].metadata[0].name
  chart      = "argo-workflows"
  version    = local.argowf.helm_chart_version
  repository = "https://argoproj.github.io/argo-helm"
  values = [
    templatefile("${path.module}/argowf_helm_values.tftpl",
      {
        region                = var.region
        db_host               = module.rds_argo_workflows["this"].db_instance_endpoint
        controller_iam_arn    = module.irsa_role_argowf_controller["this"].iam_role_arn
        server_iam_arn        = module.irsa_role_argowf_server["this"].iam_role_arn
        argowf                = local.argowf
    })
  ]
}


# Database resources (Postgres)

resource "random_password" "argowf_db_password" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

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
  version = "~>6.11"

  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  identifier                  = local.argowf.db.instance_name
  db_name                     = local.argowf.db.name
  username                    = local.argowf.db.user
  password                    = random_password.argowf_db_password["this"].result
  manage_master_user_password = false
  # manage_master_user_password = true
  # master_user_secret_kms_key_id = var.kms_key_id

  engine               = "postgres"
  family               = "postgres${local.argowf.db.major_version}"
  major_engine_version = local.argowf.db.major_version
  instance_class       = local.argowf.db.instance_class

  allocated_storage     = local.argowf.db.storage
  storage_encrypted     = true
  kms_key_id            = try(var.kms_key_id, null)
  copy_tags_to_snapshot = true
  apply_immediately     = local.argowf.db.apply_immediately

  storage_type       = local.argowf.db.storage_type
  iops               = local.argowf.db.iops
  storage_throughput = local.argowf.db.storage_throughput

  iam_database_authentication_enabled = true
  multi_az                            = local.argowf.db.multi_az

  maintenance_window      = local.argowf.db.maintenance_window
  backup_window           = local.argowf.db.backup_window
  backup_retention_period = local.argowf.db.backup_retention_period

  # Network
  port                   = "5432"
  vpc_security_group_ids = [module.sg_argo_db["this"].security_group_id]
  create_db_subnet_group = true
  subnet_ids             = local.argowf.db.subnet_ids

  # Database Deletion Protection
  deletion_protection = local.argowf.db.deletion_protection
  skip_final_snapshot = local.argowf.db.skip_final_snapshot
}

module "sg_argo_db" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~>5.3"

  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  create             = true
  name               = "${local.argowf.db.instance_name}-db"
  description        = "Security group for Argo Workflows db"
  vpc_id             = var.argowf.db.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  ingress_with_source_security_group_id = [for sg_id in var.argowf.eks_nodes_sg_ids :
    {
      from_port                = "5432"
      to_port                  = "5432"
      protocol                 = "tcp"
      description              = "DB from ${sg_id}"
      source_security_group_id = sg_id
    }
  ]
}

resource "kubernetes_secret" "argowf_db_credentials" {
  for_each = toset(local.argowf_provisioner == "helm" ? ["this"] : [])

  metadata {
    name      = local.argowf.db.credentials_secret
    namespace = kubernetes_namespace.argowf["this"].id
  }
  data = {
    username = local.argowf.db.user
    password = random_password.argowf_db_password["this"].result
  }
}

