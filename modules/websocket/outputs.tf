output "websocket_api_endpoint" {
  description = "URL publique de l'API WebSocket"
  value       = aws_apigatewayv2_api.websocket_api.api_endpoint
}
output "websocket_domain_target" {
  value = aws_apigatewayv2_domain_name.websocket_domain.domain_name_configuration[0].target_domain_name
}

output "websocket_zone_id" {
  value = aws_apigatewayv2_domain_name.websocket_domain.domain_name_configuration[0].hosted_zone_id
}
