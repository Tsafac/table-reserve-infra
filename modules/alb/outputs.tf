output "alb_dns_name" {
  description = "Nom DNS public de l'ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ARN complet de l'ALB"
  value       = aws_lb.this.arn
}

output "alb_listener_https_arn" {
  description = "ARN du listener HTTPS de l'ALB"
  value       = aws_lb_listener.https.arn
}

output "alb_target_group_arn" {
  description = "ARN du target group principal (frontend)"
  value       = aws_lb_target_group.frontend.arn
}
