# Load Balancer
resource "aws_lb" "rabbit-lb" {
  name               = "${var.eks_instance_name}-rabbit-lb"
  load_balancer_type = "network"
  internal           = true
  security_groups    = [aws_security_group.load-balancer-rabbit-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

# Target group
resource "aws_alb_target_group" "default-target-group-rabbit" {
  name     = "${var.eks_instance_name}-rabbit-tg"
  port     = 5672
  protocol = "TCP"
  vpc_id   = aws_vpc.restaurante-vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "ec2-alb-http-listener_rabbit" {
  load_balancer_arn = aws_lb.rabbit-lb.id
  port              = "5672"
  protocol          = "TCP"
  depends_on        = [aws_alb_target_group.default-target-group-rabbit]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group-rabbit.arn
  }
}