output "log_group_name" {
  description = "Nom du log group ECS"
  value       = aws_cloudwatch_log_group.ecs_app_logs.name
}
