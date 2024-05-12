resource "aws_eks_access_policy_association" "example" {
  cluster_name  = aws_eks_cluster.restaurante-cluster.name
  policy_arn    = var.policyArn
  principal_arn = var.principalArn

  access_scope {
    type = "cluster"
  }
}
