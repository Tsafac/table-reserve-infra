output "ecs_execution_role_arn" {
  description = "ARN du rôle d'exécution ECS pour Fargate"
  value       = aws_iam_role.ecs_execution_role.arn
}
