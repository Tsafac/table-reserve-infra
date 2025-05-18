output "metric_name" {
  description = "Nom du Load Balancer (CloudWatch)"
  value       = aws_lb.this.name
}

output "alb_dns_name" {
  description = "Nom DNS du Load Balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Zone ID du Load Balancer (pour Route53 alias)"
  value       = aws_lb.this.zone_id
}

output "alb_arn" {
  description = "ARN du Load Balancer"
  value       = aws_lb.this.arn
}

output "target_group_arn" {
  description = "ARN du Target Group"
  value       = aws_lb_target_group.frontend.arn
}

