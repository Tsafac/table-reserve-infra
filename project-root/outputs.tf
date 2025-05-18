# === Accès utilisateur / Web ===
output "frontend_url" {
  description = "URL publique du site via CloudFront"
  value       = "https://${module.cloudfront.domain_name}"
}

output "cognito_user_pool_id" {
  description = "ID du user pool Cognito"
  value       = module.cognito.user_pool_id
}

output "cognito_client_id" {
  description = "ID du client Cognito"
  value       = module.cognito.client_id
}

output "cognito_login_url" {
  description = "URL de login Cognito"
  value       = "https://${module.cognito.domain}.auth.${var.aws_region}.amazoncognito.com/login"
}


# === Backend / API ===
output "ecs_fargate_service_name" {
  description = "Nom du service ECS"
  value       = module.ecs_fargate.service_name
}

output "ecs_fargate_image_url" {
  description = "URL de l'image utilisée par ECS"
  value       = module.ecr.repository_url
}

output "websocket_api_id" {
  description = "ID de l'API WebSocket"
  value       = module.websocket.api_id
}

# === Sécurité / Monitoring ===
output "cloudtrail_arn" {
  description = "ARN du trail CloudTrail"
  value       = module.security.cloudtrail_arn
}

output "guardduty_detector_id" {
  description = "ID du détecteur GuardDuty"
  value       = module.security.guardduty_id
}

output "cloudwatch_log_group_ecs" {
  description = "Nom du log group CloudWatch pour ECS"
  value       = module.cloudwatch.log_group_name
}

# === Base de données ===
output "aurora_cluster_endpoint" {
  description = "Endpoint de connexion Aurora"
  value       = module.aurora.cluster_endpoint
}

output "aurora_secret_arn" {
  description = "ARN du secret contenant les infos DB"
  value       = module.aurora.secret_arn
}

# === Réseau / Accès direct ===
output "alb_dns_name" {
  description = "Nom DNS de l’ALB"
  value       = module.alb.alb_dns_name
}

output "bastion_ip" {
  description = "Adresse IP publique de la Bastion"
  value       = module.bastion.bastion_public_ip
}


output "debug_alb_module" {
  value = module.alb
}
