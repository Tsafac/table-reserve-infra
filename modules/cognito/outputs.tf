output "user_pool_id" {
  description = "ID du User Pool Cognito"
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_client_id" {
  description = "ID du client Cognito pour l'application"
  value       = aws_cognito_user_pool_client.web_app.id
}

output "cognito_domain_url" {
  description = "URL complète du domaine Cognito"
  value       = "https://${aws_cognito_user_pool_domain.main.domain}.auth.${var.aws_region}.amazoncognito.com"
}

output "client_id" {
  description = "ID du client Cognito pour l'application web"
  value       = aws_cognito_user_pool_client.web_app.id
}

output "domain" {
  description = "Préfixe du domaine Cognito"
  value       = aws_cognito_user_pool_domain.main.domain
}

