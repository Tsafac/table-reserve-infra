# Général
variable "name_prefix" {
  description = "Préfixe commun pour nommer les ressources"
  type        = string
}

variable "domain_name" {
  description = "Nom logique du domaine (utilisé dans les tags)"
  type        = string
}

variable "default_tags" {
  description = "Map de tags communs"
  type        = map(string)
}

# Réseau et sécurité
variable "aurora_subnet_ids" {
  description = "Liste des subnets privés pour Aurora"
  type        = list(string)
}

variable "aurora_sg_id" {
  description = "ID du Security Group Aurora fourni par le module sg"
  type        = string
}

variable "ecs_service_sg_id" {
  description = "ID du Security Group de Fargate autorisé à accéder à Aurora"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN de la clé KMS utilisée pour chiffrer la base Aurora"
  type        = string
}

# Base de données
variable "db_username" {
  description = "Nom de l'utilisateur principal de la base"
  type        = string
}

variable "db_password" {
  description = "Mot de passe de l'utilisateur principal"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nom initial de la base de données"
  type        = string
}

variable "db_instance_class" {
  description = "Classe des instances Aurora"
  type        = string
}

variable "aurora_instance_count" {
  description = "Nombre d'instances Aurora"
  type        = number
  default     = 1
}
