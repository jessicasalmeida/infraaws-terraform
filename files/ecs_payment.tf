resource "aws_ecs_service" "ecs_payment_service" {
  name                = "payment-ecs-service"
  cluster             = aws_ecs_cluster.ecs_cluster.id
  task_definition     = aws_ecs_task_definition.ecs_payment_task_definition.arn
  desired_count       = 1
  scheduling_strategy = "REPLICA"

  network_configuration {
    subnets         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_groups = [aws_security_group.payment_sg.id]
  }
  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 1
  }

  load_balancer {
    container_name   = "payment"
    container_port   = "3000"
    target_group_arn = aws_alb_target_group.default-target-group-payment.arn
  }

  force_new_deployment = true

  deployment_controller {
    type = "ECS"
  }
  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = plantimestamp()
  }

}
resource "aws_appautoscaling_target" "ecs_payment_target" {
  max_capacity = 5
  min_capacity = 1
  resource_id  = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_payment_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

}

resource "aws_appautoscaling_policy" "my_scaling_policy_payment" {
  name               = "meu-scaling-policy-payment"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_payment_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_payment_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_payment_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    scale_in_cooldown  = 2048
    scale_out_cooldown = 2048
    target_value       = 70
  }
}