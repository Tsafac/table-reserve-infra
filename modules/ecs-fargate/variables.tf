variable "project" {
  description = "Nom du projet (préfixe pour les ressources)"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Tags communs à toutes les ressources"
  type        = map(string)
}

variable "image_url" {
  description = "Image Docker à déployer sur ECS"
  type        = string
}

variable "environment" {
  description = "Nom de l'environnement (ex: dev, staging, prod)"
  type        = string
}

variable "aurora_secret_arn" {
  description = "ARN du secret Aurora dans Secrets Manager"
  type        = string
}

variable "task_role_arn" {
  description = "ARN du rôle IAM pour la tâche ECS"
  type        = string
}

variable "ecs_sg_id" {
  description = "ID du groupe de sécurité à associer au service ECS"
  type        = string
}

variable "private_subnets" {
  description = "Liste des sous-réseaux privés pour ECS"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN du target group à associer au service ECS"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN du rôle d'exécution ECS"
  type        = string
}

variable "service_sg_id" {
  description = "ID du Security Group pour le service ECS"
  type        = string
}



