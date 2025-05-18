output "distribution_id" {
  description = "ID de la distribution CloudFront"
  value       = aws_cloudfront_distribution.alb_distribution.id
}

output "distribution_domain_name" {
  description = "Nom de domaine attribué par CloudFront"
  value       = aws_cloudfront_distribution.alb_distribution.domain_name
}

output "cloudfront_domain_name" {
  description = "Domaine CloudFront généré par AWS"
  value       = aws_cloudfront_distribution.alb_distribution.domain_name
}

output "domain_name" {
  description = "Nom de domaine généré automatiquement par CloudFront"
  value       = aws_cloudfront_distribution.alb_distribution.domain_name
}
