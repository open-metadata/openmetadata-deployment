resource "okta_app_oauth" "app_omd" {
  label                     = var.oauth_app_label
  type                      = "browser"
  grant_types               = var.oauth_app_grant_types
  redirect_uris             = var.redirect_uris
  post_logout_redirect_uris = var.logout_redirect_uris
  implicit_assignment       = true
  response_types            = ["token", "code"]
}