variable "zone_name" {
  type        = string
  description = "Nom de la zone DNS"
}

variable "alb_dns_name" {
  type        = string
  description = "Nom DNS du load balancer"
}

variable "alb_dns_zone_id" {
  type        = string
  description = "Zone ID du load balancer"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags communs appliqués aux enregistrements DNS"
}

variable "domain_name" {
  type        = string
  description = "Nom de domaine complet pour taguer les ressources"
}

variable "project" {
  type        = string
  description = "Nom du projet (pour les tags)"
}
variable "websocket_domain_target" {
  description = "Nom de domaine cible pour le WebSocket (API Gateway)"
  type        = string
}

variable "websocket_zone_id" {
  description = "Zone ID de l’API Gateway WebSocket"
  type        = string
}

