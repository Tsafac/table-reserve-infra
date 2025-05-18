
variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
}

variable "aws_profile" {
  description = "Profil AWS CLI à utiliser"
  type        = string
}

variable "name_prefix" {
  description = "Préfixe utilisé pour nommer toutes les ressources"
  type        = string
}

variable "project" {
  description = "Nom logique du projet (ex: reservation-app)"
  type        = string
}

variable "domain_name" {
  description = "Nom du domaine logique (utilisé pour les tags et DNS)"
  type        = string
}

variable "environment" {
  description = "Nom de l'environnement (ex: dev, staging, prod)"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux appliqués à toutes les ressources"
  type        = map(string)
  default = {
    Project     = "unify-infra"
    Environment = "dev"
    Owner       = "DevOps"
  }
}

# Réseau
variable "vpc1_cidr_block" {
  description = "CIDR block du VPC public"
  type        = string
}

variable "vpc2_cidr_block" {
  description = "CIDR block du VPC privé"
  type        = string
}

# Cognito
variable "callback_urls" {
  description = "Liste des URLs de callback Cognito"
  type        = list(string)
}

variable "logout_urls" {
  description = "Liste des URLs de déconnexion Cognito"
  type        = list(string)
}

variable "cognito_domain_prefix" {
  description = "Préfixe du domaine Cognito"
  type        = string
}

# DNS / Route 53
variable "zone_name" {
  description = "Nom du domaine public hébergé dans Route 53"
  type        = string
}

# Budget
variable "budget_limit" {
  description = "Montant du budget mensuel AWS en USD"
  type        = string
}

variable "budget_notification_email" {
  description = "Adresse e-mail pour recevoir les alertes de budget"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR du subnet public dans VPC 1"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR du subnet public dans VPC 2"
  type        = string
}

variable "private_subnet_1" {
  description = "CIDR du subnet privé 1 dans VPC 2"
  type        = string
}

variable "private_subnet_2" {
  description = "CIDR du subnet privé 2 dans VPC 2"
  type        = string
}

variable "availability_zone" {
  description = "Zone de disponibilité utilisée pour les subnets"
  type        = string
}

variable "db_password" {
  description = "Mot de passe du super utilisateur de la base Aurora"
  type        = string
}

variable "domain_name_backend" {
  description = "Nom de domaine backend pour le certificat ACM"
  type        = string
}

variable "hosted_zone_id" {
  description = "ID de la zone hébergée dans Route 53"
  type        = string
}

variable "integration_uri" {
  description = "URI HTTP intégré à l'API WebSocket"
  type        = string
}

variable "bastion_ami_id" {
  description = "AMI pour le Bastion"
  type        = string
}

variable "bastion_instance_type" {
  description = "Type d'instance EC2 pour le Bastion"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nom de la paire de clés SSH"
  type        = string
}

variable "alternate_names" {
  description = "SANs pour le certificat CloudFront"
  type        = list(string)
  default     = []
}

variable "alternate_names_backend" {
  description = "SANs pour le certificat backend"
  type        = list(string)
  default     = []
}

variable "execution_role_arn" {
  description = "ARN du rôle d'exécution ECS"
  type        = string
}

variable "kms_aurora_key_arn" {
  description = "ARN of the KMS key used for Aurora encryption"
  type        = string
  default     = "" 
}
