variable "hosted_zone_id" {
  description = "ID de la zone DNS Route53"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine principal pour CloudFront (frontend)"
  type        = string
}

variable "alternate_names" {
  description = "Noms alternatifs (SANs) pour le certificat CloudFront"
  type        = list(string)
  default     = []
}

variable "domain_name_backend" {
  description = "Nom de domaine utilisé pour le backend (ALB / WebSocket)"
  type        = string
}

variable "alternate_names_backend" {
  description = "Noms alternatifs pour le certificat backend"
  type        = list(string)
  default     = []
}

variable "project" {
  description = "Nom du projet"
  type        = string
  default     = "reservation-app"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
}


