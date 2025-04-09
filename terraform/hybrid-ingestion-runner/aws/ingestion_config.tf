#locals {
#  ingestion_defaults = {
#    image = {
#      repository = "openmetadata/ingestion-base"
#      tag        = "1.6.0"
#    }
#  }
#
#  ingestion = {
#    image = {
#      repository = coalesce(
#        try(var.ingestion.image.repository, null),
#        local.ingestion_defaults.image.repository)
#      tag = coalesce(
#        try(var.ingestion.image.tag, null),
#	local.ingestion_defaults.image.tag)
#    }
#    extra_envs = try(var.ingestion.extra_envs, null)
#    pod_annotations = try(var.ingestion.pod_annotations, null)
#  }  
#}
