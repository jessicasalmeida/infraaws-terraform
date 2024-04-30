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

resource "aws_apigatewayv2_route" "example" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.albintegration.id}"
}


resource "aws_apigatewayv2_integration" "albintegration" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_alb_listener.ec2-alb-http-listener.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.main.id

}
