#module "eks" {
#  source = "terraform-aws-modules/eks/aws"
#  version = "18.19.0"
#
#  cluster_name                    = "${var.eks_instance_name}"
#  cluster_version                 = "1.29"
#  cluster_endpoint_private_access = true
#  cluster_endpoint_public_access  = true
#  cluster_additional_security_group_ids = [aws_security_group.eks.id]
#
#  vpc_id     = aws_vpc.restaurante-vpc.id
#  subnet_ids = [var.private_subnet_2_cidr, var.private_subnet_1_cidr]
#
#  eks_managed_node_group_defaults = {
#    ami_type               = "AL2_x86_64"
#    disk_size              = 50
#    instance_types         = ["t3.micro", "t3.micro"]
#    vpc_security_group_ids = [aws_security_group.eks.id]
#  }
#
#  eks_managed_node_groups = {
#    var.nodeName = {
#      min_size     = 1
#      max_size     = 10
#      desired_size = 3
#
#      instance_types = ["t3.micro"]
#      capacity_type  = "SPOT"
#      taints = {
#      }
#    }
#  }
#}
