# Load Balancer
resource "aws_lb" "payment-lb" {
  name               = "${var.eks_instance_name}-payment-lb"
  load_balancer_type = "application"
  internal           = true
  security_groups    = [aws_security_group.load-balancer-payment-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

# Target group
resource "aws_alb_target_group" "default-target-group-payment" {
  name     = "${var.eks_instance_name}-payment-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.restaurante-vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "ec2-alb-http-listener_payment" {
  load_balancer_arn = aws_lb.payment-lb.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.default-target-group-payment]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group-payment.arn
  }
}