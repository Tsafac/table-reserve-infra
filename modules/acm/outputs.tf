output "cloudfront_certificate_arn" {
  description = "ARN du certificat ACM pour CloudFront (us-east-1)"
  value       = aws_acm_certificate.cloudfront_cert.arn
}

output "regional_certificate_arn" {
  description = "ARN du certificat ACM pour ALB ou WebSocket (dans la région principale)"
  value       = aws_acm_certificate.regional_cert.arn
}
