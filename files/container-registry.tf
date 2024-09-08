resource "aws_ecr_repository" "repository_terraform" {
  name = "restaurante"
}

resource "aws_ecr_repository" "repository_admin" {
  name = "admin"
}

resource "aws_ecr_repository" "repository_payment" {
  name = "payment"
}

resource "aws_ecr_repository" "repository_rabbit" {
  name = "rabbit"
}

