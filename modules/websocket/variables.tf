variable "project" {
  description = "Nom du projet utilisé dans les noms des ressources"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Map de tags personnalisés pour les ressources WebSocket"
  type        = map(string)
}

variable "integration_uri" {
  description = "URI d'intégration HTTP vers le backend (ex: Lambda, ALB, ECS)"
  type        = string
}

variable "websocket_cert_arn" {
  description = "ARN du certificat ACM pour le domaine personnalisé WebSocket"
  type        = string
}

variable "websocket_domain_name" {
  description = "Nom de domaine personnalisé utilisé pour WebSocket"
  type        = string
}



