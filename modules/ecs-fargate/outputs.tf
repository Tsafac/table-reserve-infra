output "ecs_cluster_name" {
  description = "Nom du cluster ECS"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Nom du service ECS"
  value       = aws_ecs_service.app.name
}

output "ecs_task_definition_arn" {
  description = "ARN de la task definition ECS"
  value       = aws_ecs_task_definition.app.arn
}
