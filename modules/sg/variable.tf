variable "name_prefix" {
  description = "Préfixe utilisé pour nommer les Security Groups"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC dans lequel les SG seront créés"
  type        = string
}

variable "default_tags" {
  description = "Map de tags à appliquer à toutes les ressources"
  type        = map(string)
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags des ressources"
  type        = string
}

variable "authorized_cidr" {
  description = "Liste des CIDR autorisées pour l'accès SSH au bastion"
  type        = list(string)
}



