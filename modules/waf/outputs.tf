output "waf_acl_arn" {
  description = "ARN de la Web ACL (à passer au module CloudFront)"
  value       = aws_wafv2_web_acl.waf.arn
}

