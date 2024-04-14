resource "aws_eks_access_entry" "access" {
  cluster_name      = aws_eks_cluster.fiap.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["fiap", "pos-tech"]
  type              = "STANDARD"

}