output "cloudtrail_arn" {
  description = "ARN du trail principal"
  value       = aws_cloudtrail.main.arn
}

output "guardduty_id" {
  description = "ID du détecteur GuardDuty"
  value       = aws_guardduty_detector.main.id
}
