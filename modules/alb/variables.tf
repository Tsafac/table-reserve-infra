variable "name_prefix" {
  description = "Préfixe utilisé pour nommer les ressources (ex : reservation-app)"
  type        = string
}

variable "public_subnets" {
  description = "Liste des IDs de sous-réseaux publics pour l'ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID du VPC dans lequel se trouve l'ALB"
  type        = string
}

variable "security_group_ids" {
  description = "Liste des groupes de sécurité associés à l'ALB"
  type        = list(string)
}

variable "default_tags" {
  description = "Tags à appliquer sur toutes les ressources"
  type        = map(string)
}
