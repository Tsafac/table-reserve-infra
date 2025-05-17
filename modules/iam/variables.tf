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

variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom logique pour les tags"
  type        = string
}

variable "default_tags" {
  description = "Map de tags globaux"
  type        = map(string)
}
