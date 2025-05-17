variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom logique du projet pour les tags"
  type        = string
}

variable "default_tags" {
  description = "Map des tags globaux"
  type        = map(string)
}

variable "budget_limit" {
  description = "Montant du budget mensuel en USD"
  type        = string
  default     = "30"
}

variable "budget_notification_email" {
  description = "Adresse email pour alerte budget"
  type        = string
}
