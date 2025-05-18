variable "name_prefix" {
  description = "Préfixe pour les noms de ressources"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé pour taguer les ressources"
  type        = string
}

variable "default_tags" {
  description = "Tags communs à appliquer sur les ressources"
  type        = map(string)
}

variable "security_group_ids" {
  description = "Liste des groupes de sécurité associés à l'ALB"
  type        = list(string)
}

variable "public_subnets" {
  description = "Liste des sous-réseaux publics pour déployer l'ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID du VPC dans lequel déployer le Target Group"
  type        = string
}

variable "certificate_arn" {
  description = "ARN du certificat SSL pour l'ALB (depuis le module ACM)"
  type        = string
}



