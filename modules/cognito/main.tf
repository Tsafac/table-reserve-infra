resource "aws_cognito_user_pool" "main" {
  name = "user-pool-${var.project}"

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
  }

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}

resource "aws_cognito_user_pool_client" "web_app" {
  name         = "frontend-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_CUSTOM_AUTH"
  ]

  supported_identity_providers = ["COGNITO"]
  callback_urls                = var.callback_urls
  logout_urls                  = var.logout_urls
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.cognito_domain_prefix
  user_pool_id = aws_cognito_user_pool.main.id
}
