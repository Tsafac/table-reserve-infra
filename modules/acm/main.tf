#Certificat pour CloudFront (us-east-1)
resource "aws_acm_certificate" "cloudfront_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = var.alternate_names

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.default_tags, {
  Name = var.domain_name
})
}

resource "aws_route53_record" "cloudfront_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

# Certificat pour ALB / WebSocket (dans ta région principale)
resource "aws_acm_certificate" "regional_cert" {
  domain_name       = var.domain_name_backend
  validation_method = "DNS"
  subject_alternative_names = var.alternate_names_backend

  lifecycle {
    create_before_destroy = true
  }

   tags = merge(var.default_tags, {
  Name = var.domain_name
})

}

resource "aws_route53_record" "regional_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.regional_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}
