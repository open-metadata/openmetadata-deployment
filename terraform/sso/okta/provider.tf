terraform {
  required_providers {
    okta = {
      source = "okta/okta"
    }
  }
}

provider "okta" {
  org_name = var.org_name
  base_url = var.base_url
}