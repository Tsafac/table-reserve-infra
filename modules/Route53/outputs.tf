output "www_record" {
  description = "Nom complet de l’enregistrement www"
  value       = aws_route53_record.www.fqdn
}

output "websocket_record" {
  description = "Nom complet de l’enregistrement WebSocket"
  value       = aws_route53_record.websocket.fqdn
}
