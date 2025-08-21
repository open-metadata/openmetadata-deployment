locals {
  argowf_provisioner = coalesce(
    try(var.argowf.provisioner, null),
    "helm"
  )

  argowf_defaults = {
    helm_chart_version     = "0.40.8"
    namespace              = "argo-workflows-${var.environment}"
    controller_sa_name     = "argo-workflows-controller"
    server_sa_name         = "argo-workflows-server"
    storage_account_name   = lower("argowf${var.environment}${random_string.storage_account_suffix.result}")
    storage_container_name = lower("argoworkflows${var.environment}")
    crd_enabled            = true
    db = {
      apply_immediately     = true
      sku_name              = "B_Standard_B2ms"
      name                  = "argowf"
      version               = "16"
      administrator_login   = "dbadmin"
      credentials_secret    = "argowf-db-${var.environment}"
      storage_mb            = 32768
      backup_retention_days = 7
      geo_redundant_backup  = false
      auto_grow_enabled     = true
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
    storage_account_name = coalesce(
      try(var.argowf.storage_account_name, null),
    local.argowf_defaults.storage_account_name)
    storage_container_name = coalesce(
      try(var.argowf.storage_container_name, null),
    local.argowf_defaults.storage_container_name)
    crd_enabled = coalesce(
      try(var.argowf.crd_enabled, null),
    local.argowf_defaults.crd_enabled)
    db = {
      apply_immediately = coalesce(
        try(var.argowf.db.apply_immediately, null),
      local.argowf_defaults.db.apply_immediately)
      name = coalesce(
        try(var.argowf.db.name, null),
      local.argowf_defaults.db.name)
      sku_name = coalesce(
        try(var.argowf.db.sku_name, null),
      local.argowf_defaults.db.sku_name)
      version = coalesce(
        try(var.argowf.db.version, null),
      local.argowf_defaults.db.version)
      administrator_login = coalesce(
        try(var.argowf.db.administrator_login, null),
      local.argowf_defaults.db.administrator_login)
      credentials_secret = coalesce(
        try(var.argowf.db.credentials_secret, null),
      local.argowf_defaults.db.credentials_secret)
      storage_mb = coalesce(
        try(var.argowf.db.storage_mb, null),
      local.argowf_defaults.db.storage_mb)
      backup_retention_days = coalesce(
        try(var.argowf.db.backup_retention_days, null),
      local.argowf_defaults.db.backup_retention_days)
      auto_grow_enabled = coalesce(
        try(var.argowf.db.auto_grow_enabled, null),
      local.argowf_defaults.db.auto_grow_enabled)
    }
  } : null

  argowf_existing = local.argowf_provisioner == "existing" ? var.argowf : null

  argowf_config = {
    helm     = local.argowf_helm
    existing = local.argowf_existing
  }

  argowf = local.argowf_config[local.argowf_provisioner]
}