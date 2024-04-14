resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.fiap.name
  node_group_name = var.nodeName
  node_role_arn   = var.labRole
  subnet_ids      = ["${var.subnetA}", "${var.subnetB}"]
  disk_size       = 20
  instance_types  = ["t3.micro"]
  capacity_type   = "SPOT"


  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

}