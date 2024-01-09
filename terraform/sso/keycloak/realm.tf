resource "keycloak_realm" "omd_realm" {
  realm             = var.realm
  enabled           = true
  display_name      = var.realm_display_name
}