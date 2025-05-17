resource "aws_apigatewayv2_api" "websocket_api" {
  name                        = "${var.project}-websocket-api"
  protocol_type               = "WEBSOCKET"
  route_selection_expression  = "$request.body.action"

  tags = merge(var.tags, {
    Name = var.domain_name
  })
}
resource "aws_apigatewayv2_integration" "websocket_integration" {
  api_id                 = aws_apigatewayv2_api.websocket_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = var.integration_uri 
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.websocket_api.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.websocket_integration.id}"
}

resource "aws_apigatewayv2_stage" "websocket_stage" {
  api_id      = aws_apigatewayv2_api.websocket_api.id
  name        = "$default"
  auto_deploy = true

  tags = merge(var.tags, {
    Name = var.domain_name
  })
}

resource "aws_apigatewayv2_domain_name" "websocket_domain" {
  domain_name = var.websocket_domain_name

  domain_name_configuration {
    certificate_arn = var.websocket_cert_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = merge(var.tags, {
    Name = var.domain_name
  })
}

resource "aws_apigatewayv2_api_mapping" "websocket_mapping" {
  api_id      = aws_apigatewayv2_api.websocket_api.id
  domain_name = aws_apigatewayv2_domain_name.websocket_domain.id
  stage       = aws_apigatewayv2_stage.websocket_stage.id
}



