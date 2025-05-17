# Récupère la zone publique déjà créée lors de l'achat du domaine
data "aws_route53_zone" "main" {
  name         = var.zone_name
  private_zone = false
}

# Enregistrement "www" pour CloudFront ou ALB
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${var.zone_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_dns_zone_id
    evaluate_target_health = true
  }
  tags = merge(var.default_tags, {
    Name = "${var.project}-www"
  })
}

# Enregistrement "ws" pour WebSocket (API Gateway)

resource "aws_route53_record" "websocket" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "ws.${var.zone_name}"
  type    = "A"

  alias {
    name                   = var.websocket_domain_target
    zone_id                = var.websocket_zone_id
    evaluate_target_health = true
  }

  tags = merge(var.default_tags, {
    Name = "${var.project}-ws"
  })
}

