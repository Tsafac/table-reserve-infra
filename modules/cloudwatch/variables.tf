variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Tags communs appliqués à toutes les ressources"
  type        = map(string)
}

variable "retention_in_days" {
  description = "Durée de rétention des logs CloudWatch (en jours)"
  type        = number
  default     = 7
}

variable "aurora_cluster_id" {
  description = "Identifiant du cluster Aurora (pour les alarmes RDS)"
  type        = string
}

variable "alb_metric_name" {
  description = "Nom du Load Balancer (dans les métriques ALB)"
  type        = string
}

variable "waf_metric_name" {
  description = "Nom du WebACL utilisé par WAF"
  type        = string
}

