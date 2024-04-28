module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name                    = "restaurante-fiap"
  cluster_version                 = "1.24"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_additional_security_group_ids = [aws_security_group.eks.id]

  vpc_id     = aws_vpc.restaurante-vpc.id
  subnet_ids = [aws_subnet.private-subnet-1, aws_subnet.private-subnet-2]

  eks_managed_node_group_defaults = node

}
