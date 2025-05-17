variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "domain_name" {
  description = "Nom logique pour les tags"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux"
  type        = map(string)
}

variable "retention_in_days" {
  description = "Durée de rétention des logs"
  type        = number
  default     = 14
}

variable "aurora_cluster_id" {
  description = "Nom du cluster Aurora"
  type        = string
}

variable "alb_metric_name" {
  description = "Nom du LoadBalancer pour CloudWatch (ex: app/nom/uuid)"
  type        = string
}

variable "waf_metric_name" {
  description = "Nom du WAF WebACL pour CloudWatch"
  type        = string
}
