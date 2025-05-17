variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom logique du projet"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux à appliquer"
  type        = map(string)
}

variable "environment" {
  description = "Nom de l'environnement"
  type        = string
}

variable "callback_urls" {
  description = "Liste des URLs de redirection après login"
  type        = list(string)
}

variable "logout_urls" {
  description = "Liste des URLs de redirection après logout"
  type        = list(string)
}

variable "cognito_domain_prefix" {
  description = "Préfixe de domaine Cognito (ex: reservation-app)"
  type        = string
}
