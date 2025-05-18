output "execution_role_arn" {
  description = "ARN du rôle d'exécution ECS"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "execution_role_name" {
  description = "Nom du rôle ECS"
  value       = aws_iam_role.ecs_execution_role.name
}

output "ecs_execution_role_arn" {
  description = "ARN du rôle d'exécution ECS"
  value       = aws_iam_role.ecs_execution_role.arn
}
output "task_role_arn" {
  description = "ARN du rôle IAM utilisé par la tâche ECS"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "vpc_flow_logs_role_arn" {
  value = aws_iam_role.vpc_flow_logs.arn
}
