output "kms_key_id" {
  description = "ID de la clé KMS créée"
  value       = aws_kms_key.aurora_kms.key_id
}

output "kms_key_arn" {
  description = "ARN de la clé KMS créée"
  value       = aws_kms_key.aurora_kms.arn
}

output "kms_alias_name" {
  description = "Nom de l'alias de la clé KMS"
  value       = aws_kms_alias.aurora_alias.name
}
