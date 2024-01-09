resource "okta_trusted_origin" "to_omd" {
  name   = var.trusted_origin_name
  origin = var.trusted_origin_url
  scopes = ["REDIRECT"]
}