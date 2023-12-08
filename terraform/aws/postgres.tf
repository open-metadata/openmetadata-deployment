module "rds_argo_workflows" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~>6.3"

  identifier                    = var.instance_name
  db_name                       = var.db_name
  username                      = var.admin_name
  master_user_secret_kms_key_id = var.kms_key_id

  engine               = "postgres"
  family               = "postgres15"
  major_engine_version = var.major_engine_version
  instance_class       = var.db_instance_class

  allocated_storage     = var.db_storage
  storage_encrypted     = true
  kms_key_id            = var.kms_key_id
  copy_tags_to_snapshot = true
  apply_immediately     = var.apply_rds_changes_immediately

  iam_database_authentication_enabled = true
  multi_az                            = var.multi_az

  maintenance_window      = "Sat:02:00-Sat:03:00"
  backup_window           = "03:00-04:00"
  backup_retention_period = 30

  # Network
  port                   = "5432"
  vpc_security_group_ids = [module.sg_db.security_group_id]
  create_db_subnet_group = true
  subnet_ids             = data.aws_subnets.private.ids

  # Database Deletion Protection
  deletion_protection = true

  # DB Parameter Group
  parameter_group_name      = var.parameter_group_name
  create_db_parameter_group = true
  parameters                = var.parameters

  tags = merge({
    Name = var.instance_name
  }, var.tags, var.instance_tags)
}

module "sg_db" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "~>5.1"
  create             = true
  name               = "${var.instance_name}-db-${var.region}"
  description        = "Security group for ${var.instance_name} db"
  vpc_id             = var.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  ingress_with_source_security_group_id = [for sg_id in var.allow_from_sgs :
    {
      from_port                = "5432"
      to_port                  = "5432"
      protocol                 = "tcp"
      description              = "DB from ${sg_id}"
      source_security_group_id = sg_id
    }
  ]

  tags = var.tags
}