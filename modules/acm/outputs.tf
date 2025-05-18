output "cloudfront_cert_arn" {
  description = "ARN du certificat pour CloudFront (us-east-1)"
  value       = aws_acm_certificate.cloudfront_cert.arn
}

output "regional_cert_arn" {
  description = "ARN du certificat pour ALB/WebSocket"
  value       = aws_acm_certificate.regional_cert.arn
}

output "cert_arn" {
  description = "ARN du certificat CloudFront (us-east-1)"
  value       = aws_acm_certificate.cloudfront_cert.arn
}
