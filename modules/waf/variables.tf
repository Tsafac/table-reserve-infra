variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom logique pour les tags"
  type        = string
}

variable "default_tags" {
  description = "Map de tags à appliquer aux ressources"
  type        = map(string)
}

variable "alb_arn" {
  description = "ARN du Load Balancer (ALB) à protéger avec le WAF"
  type        = string
}
