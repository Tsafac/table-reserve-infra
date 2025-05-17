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

variable "alb_dns_name" {
  description = "Nom DNS public de l'ALB (ex: xxx.elb.amazonaws.com)"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Nom de domaine personnalisé pour CloudFront (ex: www.monsite.com)"
  type        = string
}

variable "acm_cert_arn" {
  description = "ARN du certificat ACM (us-east-1)"
  type        = string
}

variable "cloudfront_logs_bucket" {
  description = "Nom complet du bucket S3 pour logs CloudFront (ex: logs.monsite.com)"
  type        = string
}
