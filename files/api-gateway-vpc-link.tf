resource "aws_apigatewayv2_vpc_link" "main" {
  name        = "restaurante_vpclink"
  security_group_ids = [aws_security_group.load-balancer.id]
  subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Usage = "restaurante_vpclink"
  }
}

resource "aws_apigatewayv2_api" "main" {
  name = "restaurante-apigateway"
  protocol_type = "HTTP"

}
resource "aws_apigatewayv2_stage" "example" {
  api_id = aws_apigatewayv2_api.main.id
  name   = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "eksRoute" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.albintegration.id}"

  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
}

resource "aws_apigatewayv2_integration" "albintegration" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_alb_listener.ec2-alb-http-listener.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.main.id

}

resource "aws_apigatewayv2_vpc_link" "order_vpclink" {
  name        = "order_vpclink"
  security_group_ids = [aws_security_group.load-balancer_admin.id]
  subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Usage = "order_vpclink"
  }
}

resource "aws_apigatewayv2_route" "order_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /order"
  target = "integrations/${aws_apigatewayv2_integration.ec2_order_integration.id}"

  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
}
resource "aws_apigatewayv2_integration" "ec2_order_integration" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_alb_listener.ec2-alb-http-listener_admin.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.order_vpclink.id

}

resource "aws_apigatewayv2_authorizer" "authorizer" {
  api_id                            = aws_apigatewayv2_api.main.id
  authorizer_type                   = "JWT"
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "restaurante-authorizer"
  jwt_configuration {
    audience = [aws_cognito_user_pool_client.user_pool_client.id]
    issuer = "https://cognito-idp.us-east-1.amazonaws.com/${aws_cognito_user_pool.user_pool.id}"
  }
  depends_on = [aws_cognito_user_pool_client.user_pool_client, aws_cognito_user_pool.user_pool]
}


resource "aws_apigatewayv2_integration" "login_lambda_integration" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri  = aws_lambda_function.autenticacao-lb.arn
}

resource "aws_apigatewayv2_route" "login_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /login"
  target = "integrations/${aws_apigatewayv2_integration.login_lambda_integration.id}"
}