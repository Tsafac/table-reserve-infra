output "aurora_kms_key_id" {
  description = "ID de la clé KMS utilisée pour Aurora"
  value       = aws_kms_key.aurora_kms.key_id
}

output "aurora_kms_key_arn" {
  description = "ARN de la clé KMS utilisée pour Aurora"
  value       = aws_kms_key.aurora_kms.arn
}
