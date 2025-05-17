output "aurora_endpoint" {
  description = "Endpoint principal du cluster Aurora"
  value       = aws_rds_cluster.aurora.endpoint
}

output "aurora_secret_arn" {
  description = "ARN du secret contenant les identifiants Aurora"
  value       = aws_secretsmanager_secret.aurora_secret.arn
}
