##
## Random password
##
resource "random_password" "db_password" {
  length      = 16
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

module "db_omd" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~>6.3"

  identifier                  = var.db_instance_name
  db_name                     = "openmetadata_db"
  username                    = "dbadmin"
  password                    = random_password.db_password.result
  manage_master_user_password = false
  # manage_master_user_password = true
  # master_user_secret_kms_key_id = var.kms_key_id

  engine               = "postgres"
  family               = "postgres15"
  major_engine_version = var.db_major_version
  instance_class       = var.db_instance_class

  allocated_storage     = var.db_storage
  storage_encrypted     = true
  kms_key_id            = var.kms_key_id
  copy_tags_to_snapshot = true
  apply_immediately     = true

  iam_database_authentication_enabled = true
  multi_az                            = true

  maintenance_window      = "Sat:02:00-Sat:03:00"
  backup_window           = "03:00-04:00"
  backup_retention_period = 30

  # Network
  port                   = "5432"
  vpc_security_group_ids = [module.sg_db.security_group_id]
  create_db_subnet_group = true
  subnet_ids             = var.subnet_ids

  # Database Deletion Protection
  deletion_protection = true

  # DB Parameter Group
  parameter_group_name      = var.db_instance_name
  create_db_parameter_group = true
  parameters                = var.db_parameters
}

module "sg_db" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "~>5.1"
  create             = true
  name               = "${var.db_instance_name}-db"
  description        = "Security group for OpenMetadata db"
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
