module "s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "~>3.15"
  bucket                   = var.argowf_bucket_name
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
