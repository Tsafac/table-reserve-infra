variable "project" {
  description = "Nom du projet"
  type        = string
}
variable "ecr_repo_name" {
  description = "Nom du repository ECR"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Map de tags communs à toutes les ressources"
  type        = map(string)
}
