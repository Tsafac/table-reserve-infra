output "aurora_sg_id" {
  value = aws_security_group.aurora_sg.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "fargate_sg_id" {
  value = aws_security_group.ecs_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
