provider "kubernetes" {
  host                   = aws_eks_cluster.restaurante-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.restaurante-cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${var.eks_instance_name}"]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.restaurante-cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.restaurante-cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "${var.eks_instance_name}"]
      command     = "aws"
    }
  }
}