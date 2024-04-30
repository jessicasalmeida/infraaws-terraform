# Load Balancer
resource "aws_lb" "restaurante-lb" {
  name               = "${var.eks_instance_name}-lb"
  load_balancer_type = "application"
  internal           = true
  security_groups    = [aws_security_group.load-balancer.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

# Target group
resource "aws_alb_target_group" "default-target-group" {
  name     = "${var.eks_instance_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.restaurante-vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "ec2-alb-http-listener" {
  load_balancer_arn = aws_lb.restaurante-lb.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.default-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group.arn
  }
}
#resource "null_resource" "wait_for_nlb" {
#  provisioner "local-exec" {
#    command = <<-EOT
#      $nlbArn = "${aws_lb.restaurante-lb.arn}"
#      $active = $false
#      while (-not $active) {
#        $state = aws elbv2 describe-load-balancers --load-balancer-arns $nlbArn --query "LoadBalancers[0].State.Code" --output text
#        if ($state -eq "active") {
#          $active = $true
#        } else {
#          Start-Sleep -Seconds 10
#        }
#      }
#    EOT
#    interpreter = ["PowerShell", "-Command"]
#  }
#}