locals {

  argowf_provisioner = coalesce(
    try(var.argowf.provisioner, null),
    "helm"
  )

  argowf_defaults = {
    helm_chart_version = "0.40.8"
    namespace          = "argo-workflows-${var.environment}"
    controller_sa_name = "argo-workflows-controller"
    server_sa_name     = "argo-workflows-server"
    s3_bucket_name     = "argo-workflows-${var.environment}-${random_string.s3_bucket_suffix.result}"
    crd_enabled        = true
    db = {
      apply_immediately       = true
      instance_class          = "db.t4g.micro"
      instance_name           = "argowf-${var.environment}"
      name                    = "argowf"
      user                    = "dbadmin"
      credentials_secret      = "argowf-db-${var.environment}"
      major_version           = "17"
      storage                 = 20
      storage_type            = "gp3"
      multi_az                = false
      deletion_protection     = false
      skip_final_snapshot     = false
      maintenance_window      = "Sat:02:00-Sat:03:00"
      backup_window           = "03:00-04:00"
      backup_retention_period = 0
    }
  }

  argowf_helm = local.argowf_provisioner == "helm" ? {
    provisioner = "helm"
    helm_chart_version = coalesce(
      try(var.argowf.helm_chart_version, null),
    local.argowf_defaults.helm_chart_version)
    namespace = coalesce(
      try(var.argowf.namespace, null),
    local.argowf_defaults.namespace)
    controller_sa_name = coalesce(
      try(var.argowf.controller_sa_name, null),
    local.argowf_defaults.controller_sa_name)
    server_sa_name = coalesce(
      try(var.argowf.server_sa_name, null),
    local.argowf_defaults.server_sa_name)
    s3_bucket_name = coalesce(
      try(var.argowf.s3_bucket_name, null),
    local.argowf_defaults.s3_bucket_name)
    eks_nodes_sg_ids = var.argowf.eks_nodes_sg_ids
    crd_enabled = coalesce(
      try(var.argowf.crd_enabled, null),
    local.argowf_defaults.crd_enabled)
    db = {
      apply_immediately = coalesce(
        try(var.argowf.db.apply_immediately, null),
      local.argowf_defaults.db.apply_immediately)
      instance_class = coalesce(
        try(var.argowf.db.instance_class, null),
      local.argowf_defaults.db.instance_class)
      instance_name = coalesce(
        try(var.argowf.db.instance_name, null),
      local.argowf_defaults.db.instance_name)
      name = coalesce(
        try(var.argowf.db.name, null),
      local.argowf_defaults.db.name)
      user = coalesce(
        try(var.argowf.db.user, null),
      local.argowf_defaults.db.user)
      credentials_secret = coalesce(
        try(var.argowf.db.credentials_secret, null),
      local.argowf_defaults.db.credentials_secret)
      iops = try(var.argowf.db.iops, null)
      major_version = coalesce(
        try(var.argowf.db.major_version, null),
      local.argowf_defaults.db.major_version)
      storage = coalesce(
        try(var.argowf.db.storage, null),
      local.argowf_defaults.db.storage)
      storage_type = coalesce(
        try(var.argowf.db.storage_type, null),
      local.argowf_defaults.db.storage_type)
      storage_throughput = try(var.argowf.db.storage_throughput, null)
      multi_az = coalesce(
        try(var.argowf.db.multi_az, null),
      local.argowf_defaults.db.multi_az)
      deletion_protection = coalesce(
        try(var.argowf.db.deletion_protection, null),
      local.argowf_defaults.db.deletion_protection)
      skip_final_snapshot = coalesce(
        try(var.argowf.db.skip_final_snapshot, null),
      local.argowf_defaults.db.skip_final_snapshot)
      maintenance_window = coalesce(
        try(var.argowf.db.maintenance_window, null),
      local.argowf_defaults.db.maintenance_window)
      backup_window = coalesce(
        try(var.argowf.db.backup_window, null),
      local.argowf_defaults.db.backup_window)
      backup_retention_period = coalesce(
        try(var.argowf.db.backup_retention_period, null),
      local.argowf_defaults.db.backup_retention_period)
      vpc_id     = var.argowf.db.vpc_id
      subnet_ids = var.argowf.db.subnet_ids
    }
  } : null

  argowf_existing = local.argowf_provisioner == "existing" ? var.argowf : null

  argowf_config = {
    helm     = local.argowf_helm
    existing = local.argowf_existing
  }

  argowf = local.argowf_config[local.argowf_provisioner]
}
