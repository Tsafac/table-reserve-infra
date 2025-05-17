variable "project" {
  description = "Nom du projet pour nommer les ressources"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine associé à l'API WebSocket"
  type        = string
}


variable "integration_uri" {
  description = "URI du backend (ex: ECS ou Lambda)"
  type        = string
}

variable "websocket_domain_name" {
  description = "Nom de domaine personnalisé WebSocket"
  type        = string
}

variable "websocket_cert_arn" {
  description = "ARN du certificat ACM pour le domaine WebSocket"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux à appliquer"
  type        = map(string)
}



