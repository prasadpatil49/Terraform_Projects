# REST API via API Gateway v2 (Http API compatible with Lambda Proxy)
resource "aws_apigatewayv2_api" "lambda_api_gw" {
  name          = "${var.application_name}-${var.environment}-api-gw"
  description   = "API Gateway v2 for ${var.application_name}"
  protocol_type = "HTTP"
}

# /users route
resource "aws_apigatewayv2_route" "users_any" {
  api_id    = aws_apigatewayv2_api.lambda_api_gw.id
  route_key = "ANY /users"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# /users/{id} route
resource "aws_apigatewayv2_route" "users_id_any" {
  api_id    = aws_apigatewayv2_api.lambda_api_gw.id
  route_key = "ANY /users/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# /hello route
resource "aws_apigatewayv2_route" "hello_get" {
  api_id    = aws_apigatewayv2_api.lambda_api_gw.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# /hii route
resource "aws_apigatewayv2_route" "hii_get" {
  api_id    = aws_apigatewayv2_api.lambda_api_gw.id
  route_key = "GET /hii"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Lambda integration for API Gateway v2
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.lambda_api_gw.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.application_lambda.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
  timeout_milliseconds   = 30000
}

# Lambda permission for API GW v2
resource "aws_lambda_permission" "lambda_api_gw" {
  statement_id  = "AllowExecutionFromAPIGatewayV2"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.application_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_api_gw.execution_arn}/*/*"
}

# Deploy and stage
resource "aws_apigatewayv2_stage" "lambda_api_gw_stage" {
  api_id      = aws_apigatewayv2_api.lambda_api_gw.id
  name        = var.environment
  auto_deploy = true
}

output "lambda_api_gw_url" {
  value = aws_apigatewayv2_stage.lambda_api_gw_stage.invoke_url
}
