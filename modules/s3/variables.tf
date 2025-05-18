variable "name_prefix" {
  description = "Préfixe pour nommer les ressources"
  type        = string
}

variable "default_tags" {
  description = "Tags communs"
  type        = map(string)
}

variable "oac_policy_json" {
  description = "Politique bucket pour autoriser CloudFront via OAC"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN de la clé KMS utilisée pour chiffrer le bucket frontend"
  type        = string
}
