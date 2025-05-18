variable "name_prefix" {
  description = "Préfixe pour nommer les ressources Aurora"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Tags communs à appliquer aux ressources"
  type        = map(string)
}

variable "aurora_subnet_ids" {
  description = "Liste des ID de sous-réseaux privés pour Aurora"
  type        = list(string)
}

variable "db_username" {
  description = "Nom d'utilisateur principal pour la base Aurora"
  type        = string
}

variable "db_password" {
  description = "Mot de passe pour la base Aurora"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nom de la base de données Aurora"
  type        = string
}

variable "aurora_sg_id" {
  description = "ID du groupe de sécurité pour Aurora"
  type        = string
}

variable "kms_key_id" {
  description = "ID de la clé KMS utilisée pour le chiffrement"
  type        = string
}

variable "aurora_instance_count" {
  description = "Nombre d'instances dans le cluster Aurora"
  type        = number
  default     = 1
}

variable "db_instance_class" {
  description = "Classe d'instance pour Aurora (ex: db.serverless)"
  type        = string
}
