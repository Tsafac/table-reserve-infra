variable "ecs_service_sg_id" {
  description = "ID du Security Group ECS autorisé à accéder à Aurora"
  type        = string
}

variable "domain_name" {
  description = "Nom logique utilisé dans le tag Name"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux à appliquer à toutes les ressources"
  type        = map(string)
}
 

 variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "authorized_cidr" {
  description = "IP publique autorisée pour SSH (ex: X.X.X.X/32)"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux"
  type        = map(string)
}

variable "domain_name" {
  description = "Nom logique pour les tags"
  type        = string
}

variable "project" {
  description = "Nom du projet"
  type        = string
}

output "bastion_sg_id" {
  description = "ID du Security Group de la Bastion"
  value       = aws_security_group.bastion_sg.id
}
