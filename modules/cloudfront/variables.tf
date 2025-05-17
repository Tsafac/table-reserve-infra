variable "alb_dns_name" {
  type = string
}

variable "acm_cert_arn" {
  type = string
}

variable "cloudfront_logs_bucket" {
  type = string
}

variable "cloudfront_domain_name" {
  type = string
}

variable "project" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "domain_name" {
  type = string
}


