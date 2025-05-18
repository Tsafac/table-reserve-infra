variable "project" {
  description = "Nom du projet utilisé dans l'alias KMS"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé pour tagger la ressource"
  type        = string
}

variable "default_tags" {
  description = "Map de tags communs à toutes les ressources"
  type        = map(string)
}

output "frontend_key_arn" {
  description = "ARN de la clé KMS utilisée pour chiffrer le bucket frontend"
  value       = aws_kms_key.frontend_key.arn
}

