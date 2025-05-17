variable "project" {
  description = "Nom du projet"
  type        = string
  default     = "reservation-app"
}

variable "environment" {
  description = "Nom de l'environnement (dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "execution_role_arn" {
  description = "ARN du rôle d'exécution ECS"
  type        = string
}

variable "task_role_arn" {
  description = "ARN du rôle de tâche ECS (pour accès à d'autres services)"
  type        = string
}

variable "image_url" {
  description = "URL complète de l'image Docker (ECR ou Docker Hub)"
  type        = string
}

variable "private_subnets" {
  description = "Liste des sous-réseaux privés pour le service ECS"
  type        = list(string)
}

variable "service_sg_id" {
  description = "ID du security group associé au service ECS"
  type        = string
}

variable "target_group_arn" {
  description = "ARN du target group ALB vers lequel rediriger le trafic"
  type        = string
}

variable "aurora_secret_arn" {
  description = "ARN du secret stocké dans AWS Secrets Manager pour la base Aurora"
  type        = string
}

