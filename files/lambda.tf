resource "aws_lambda_function" "autenticacao-lb" {
  filename      = "../lambda.zip"
  function_name = "login"
  role          = var.labRole
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  # Define as variáveis de ambiente
  environment {
    variables = {
      USER_POOL_ID   = aws_cognito_user_pool.user_pool.id
      CLIENT_ID      = aws_cognito_user_pool_client.user_pool_client.id
      REGION = var.region
      ACCESS_KEY_ID = var.access_key
      SECRET_ACCESS_KEY = var.secret_key
      TOKEN = var.token
    }
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.autenticacao-lb.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*"
}

output "lambda_function_arn" {
  value = aws_lambda_function.autenticacao-lb.arn
}