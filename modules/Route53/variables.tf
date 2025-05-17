variable "zone_name" {
  description = "Nom du domaine acheté (ex: monsite.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "Nom DNS de l'ALB (ex: abc.elb.amazonaws.com)"
  type        = string
}

variable "alb_dns_zone_id" {
  description = "ID de zone de l'ALB (voir doc AWS pour chaque région)"
  type        = string
}
