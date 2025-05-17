variable "vpc_id" {
  type        = string
  description = "ID du VPC où créer les SG"
}

variable "authorized_cidr" {
  type        = list(string)
  description = "Liste des CIDR autorisés à accéder en SSH (bastion)"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags communs"
}

variable "domain_name" {
  type        = string
  description = "Nom de domaine du projet (pour tag)"
}

variable "name_prefix" {
  type        = string
  description = "Préfixe pour nommer les ressources SG"
}



