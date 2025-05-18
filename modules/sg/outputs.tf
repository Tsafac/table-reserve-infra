output "aurora_sg_id" {
  description = "ID du Security Group Aurora"
  value       = aws_security_group.aurora_sg.id
}

output "ecs_sg_id" {
  description = "ID du Security Group ECS"
  value       = aws_security_group.ecs_sg.id
}

output "bastion_sg_id" {
  description = "ID du Security Group Bastion"
  value       = aws_security_group.bastion_sg.id
}

output "fargate_sg_id" {
  description = "Alias pour le SG ECS utilisé par Fargate"
  value       = aws_security_group.ecs_sg.id
}

output "alb_sg_id" {
  description = "ID du Security Group ALB"
  value       = aws_security_group.alb.id
}
