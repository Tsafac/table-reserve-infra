output "aurora_endpoint" {
  description = "Endpoint principal du cluster Aurora"
  value       = aws_rds_cluster.aurora.endpoint
}

output "aurora_reader_endpoint" {
  description = "Endpoint en lecture du cluster Aurora"
  value       = aws_rds_cluster.aurora.reader_endpoint
}

output "aurora_secret_arn" {
  description = "ARN du secret contenant les identifiants Aurora"
  value       = aws_secretsmanager_secret.aurora_secret.arn
}

output "cluster_id" {
  description = "ID du cluster RDS Aurora"
  value       = aws_rds_cluster.aurora.id
}

output "cluster_endpoint" {
  description = "Endpoint principal du cluster Aurora"
  value       = aws_rds_cluster.aurora.endpoint
}

output "secret_arn" {
  description = "ARN du secret contenant les identifiants de connexion Aurora"
  value       = aws_secretsmanager_secret.aurora_secret.arn
}
