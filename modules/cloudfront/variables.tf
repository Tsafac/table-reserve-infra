variable "project" {
  description = "Nom du projet, utilisé pour les origines CloudFront"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name de l'Application Load Balancer"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Nom de domaine (alias) pour la distribution CloudFront"
  type        = string
}

variable "cloudfront_logs_bucket" {
  description = "Bucket S3 pour stocker les logs CloudFront"
  type        = string
}

variable "acm_cert_arn" {
  description = "ARN du certificat ACM pour CloudFront (us-east-1)"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé dans les tags"
  type        = string
}

variable "default_tags" {
  description = "Map de tags communs à appliquer aux ressources"
  type        = map(string)
}



