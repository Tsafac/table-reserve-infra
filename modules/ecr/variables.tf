variable "ecr_repo_name" {
  description = "Nom du repository ECR"
  type        = string
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

variable "domain_name" {
  type        = string
  description = "Nom de domaine principal"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags communs à toutes les ressources"
}


