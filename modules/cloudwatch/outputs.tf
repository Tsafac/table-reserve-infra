output "cloudwatch_log_group_name" {
  description = "Nom du groupe de logs ECS"
  value       = aws_cloudwatch_log_group.ecs_app_logs.name
}

output "ecs_error_alarm_name" {
  description = "Nom de l'alarme ECS"
  value       = aws_cloudwatch_metric_alarm.ecs_error_alarm.alarm_name
}

output "log_group_name" {
  description = "Nom du log group principal utilisé par ECS"
  value       = aws_cloudwatch_log_group.ecs_app_logs.name
}
