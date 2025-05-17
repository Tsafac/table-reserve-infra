output "cloudfront_distribution_domain_name" {
  description = "Nom DNS de la distribution CloudFront"
  value       = aws_cloudfront_distribution.alb_distribution.domain_name
}


