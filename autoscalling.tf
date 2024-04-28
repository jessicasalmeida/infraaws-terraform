resource "aws_autoscaling_group" "restaurante-cluster" {
  name                 = "${var.eks_instance_name}_auto_scaling_group"
  min_size             = var.autoscale_min
  max_size             = var.autoscale_max
  desired_capacity     = var.autoscale_desired
  health_check_type    = "EKS"
  launch_configuration = aws_launch_configuration.XPTO.name
  vpc_zone_identifier  = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  target_group_arns    = [aws_alb_target_group.default-target-group.arn]
}