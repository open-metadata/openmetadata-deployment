# The random_string resource is used to generate a random suffix for the bucket name if the s3_bucket_name variable is not provided.
resource "random_string" "s3_bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

module "s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "~>4.6"
  bucket                   = local.argowf.s3_bucket_name
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
