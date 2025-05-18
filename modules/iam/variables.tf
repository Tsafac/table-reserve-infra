variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom logique pour le tag Name"
  type        = string
}

variable "default_tags" {
  description = "Map de tags globaux à appliquer"
  type        = map(string)
}

variable "aurora_secret_arn" {
  description = "ARN du secret contenant les identifiants Aurora dans Secrets Manager"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "ID du compte AWS"
  type        = string
}

variable "kms_aurora_key_arn" {
  description = "ARN de la clé KMS utilisée pour chiffrer les secrets Aurora"
  type        = string
}

variable "name_prefix" {
  description = "Préfixe utilisé pour nommer les ressources IAM"
  type        = string
}

