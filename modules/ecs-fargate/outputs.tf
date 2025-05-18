output "ecs_cluster_id" {
  description = "ID du cluster ECS"
  value       = aws_ecs_cluster.main.id
}

output "ecs_service_name" {
  description = "Nom du service ECS"
  value       = aws_ecs_service.app.name
}

output "task_definition_arn" {
  description = "ARN de la task definition ECS"
  value       = aws_ecs_task_definition.app.arn
}

output "service_uri" {
  value = "http://${var.domain_name}"
}

output "service_name" {
  description = "Nom du service ECS Fargate"
  value       = aws_ecs_service.app.name
}
