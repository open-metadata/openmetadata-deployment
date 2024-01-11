resource "aws_cognito_user_pool" "omd_user_pool" {
  name = var.user_pool_name
  alias_attributes  = var.user_pool_alias_attributes

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
    from_email_address    = var.from_email_address
  }
}

resource "aws_cognito_user_pool_domain" "omd_user_pool_domain" {
  domain       = var.user_pool_domain
  user_pool_id = aws_cognito_user_pool.omd_user_pool.id
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                                 = var.user_pool_client_name
  user_pool_id                         = aws_cognito_user_pool.omd_user_pool.id
  callback_urls                        = var.client_callback_urls
}