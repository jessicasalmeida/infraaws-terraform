  resource "aws_eks_cluster" "restaurante-cluster" {
  name     = "restaurante-fiap"
  role_arn = var.labRole


  vpc_config {
    endpoint_private_access = true
    subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_group_ids = [aws_security_group.eks.id]
  }

  access_config {
    authentication_mode = var.accessConfig
  }
}