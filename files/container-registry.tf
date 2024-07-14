resource "aws_ecr_repository" "repository_terraform" {
  name = "restaurante"
}

resource "aws_ecr_repository" "repository_admin" {
  name = "admin"
}