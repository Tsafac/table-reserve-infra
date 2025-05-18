output "websocket_api_id" {
  description = "ID de l'API WebSocket"
  value       = aws_apigatewayv2_api.websocket_api.id
}

output "websocket_api_endpoint" {
  description = "URL de l'API WebSocket"
  value       = aws_apigatewayv2_api.websocket_api.api_endpoint
}

output "websocket_custom_domain" {
  description = "Nom de domaine personnalisé WebSocket"
  value       = aws_apigatewayv2_domain_name.websocket_domain.domain_name
}

output "websocket_domain_target" {
  description = "Nom DNS du domaine WebSocket (à utiliser dans Route53)"
  value       = aws_apigatewayv2_domain_name.websocket_domain.domain_name_configuration[0].target_domain_name
}

output "websocket_zone_id" {
  description = "Zone ID du domaine personnalisé WebSocket pour les enregistrements Route53"
  value       = aws_apigatewayv2_domain_name.websocket_domain.domain_name_configuration[0].hosted_zone_id
}

output "api_id" {
  description = "ID de l'API WebSocket"
  value       = aws_apigatewayv2_api.websocket_api.id
}
