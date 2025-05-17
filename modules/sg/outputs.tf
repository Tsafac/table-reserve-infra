output "aurora_security_group_id" {
  description = "ID du Security Group appliqué à Aurora"
  value       = aws_security_group.aurora_sg.id
}
