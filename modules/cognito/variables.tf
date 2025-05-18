variable "project" {
  description = "Nom du projet utilisé pour nommer la User Pool"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine principal utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Map de tags communs"
  type        = map(string)
}

variable "callback_urls" {
  description = "Liste des URLs autorisées après connexion"
  type        = list(string)
}

variable "logout_urls" {
  description = "Liste des URLs de redirection après déconnexion"
  type        = list(string)
}

variable "cognito_domain_prefix" {
  description = "Préfixe personnalisé pour le domaine Cognito (auth URL)"
  type        = string
}


variable "aws_region" {
  description = "Région AWS où Cognito est déployé (utilisée pour construire l'URL du domaine)"
  type        = string
}
