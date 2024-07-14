resource "aws_cognito_user_pool" "user_pool" {
  name = "users_restaurante"
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = "login-restaurante-fiap3"
  user_pool_id    = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                     = "user_pool_client"
  user_pool_id             = aws_cognito_user_pool.user_pool.id
  generate_secret          = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows      = ["code", "implicit"]
  allowed_oauth_scopes     = ["openid", "email", "profile"]
  callback_urls            = ["https://example.com/callback"]
  logout_urls              = ["https://example.com/logout"]
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows      =  ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_ADMIN_USER_PASSWORD_AUTH"]

}

resource "aws_cognito_user" "default_user" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  username     = "fiap"
  password = "Fase!324"
}

locals {
  user_pool_id     = aws_cognito_user_pool.user_pool.id
  user_pool_endPoint = aws_cognito_user_pool.user_pool.endpoint
  client_id        = aws_cognito_user_pool_client.user_pool_client.id
  cognito_domain   = aws_cognito_user_pool_domain.main.id
}

output "user_pool_id" {
  value = local.user_pool_id
}

output "user_pool_endPoint" {
  value = local.user_pool_endPoint
}

output "client_id" {
  value = local.client_id
}

output "cognito_domain" {
  value = local.cognito_domain
}