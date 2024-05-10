resource "aws_ecr_repository" "repository_terraform" {
  name = "restaurante"
}

# Provisionamento da imagem usando o AWS CLI
resource "null_resource" "push_image_to_ecr" {
  provisioner "local-exec" {
    command = <<EOF
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.repository_terraform.repository_url}

      docker tag restaurante:latest ${aws_ecr_repository.repository_terraform.repository_url}:latest

      docker push ${aws_ecr_repository.repository_terraform.repository_url}:latest
    EOF
  }
  triggers = {
    redeployment = true
  }

  # Dependência do recurso para garantir que ele seja executado após a criação do repositório ECR
  depends_on = [aws_ecr_repository.repository_terraform]
}
#
## get authorization credentials to push to ecr
#data "aws_ecr_authorization_token" "token" {}
#
## configure docker provider
#provider "docker" {
#  registry_auth {
#    address = data.aws_ecr_authorization_token.token.proxy_endpoint
#    username = data.aws_ecr_authorization_token.token.user_name
#    password  = data.aws_ecr_authorization_token.token.password
#  }
#}
## build docker image
#resource "docker_image" "my-docker-image" {
#  name = "${data.aws_ecr_authorization_token.token.proxy_endpoint}/restaurante:latest"
#  build {
#    context = "."
#  }
#  platform = "linux/X86_64"
#}
#
## push image to ecr repo
#resource "docker_registry_image" "media-handler" {
#  name = docker_image.my-docker-image.name
#}