resource "aws_ecs_service" "ecs_service" {
  name                = "restaurante-ecs-service"
  cluster             = aws_ecs_cluster.ecs_cluster.id
  task_definition     = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count       = 1
  scheduling_strategy = "REPLICA"

  network_configuration {
    subnets         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_groups = [aws_security_group.eks.id]
  }
  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 1
  }

  load_balancer {
    container_name   = "restaurante"
    container_port   = "8000"
    target_group_arn = aws_alb_target_group.default-target-group.arn
  }

  force_new_deployment = true

  deployment_controller {
    type = "ECS"
  }
  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = timestamp()
  }

}
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"

resource "aws_appautoscaling_policy" "my_scaling_policy" {
  name               = "meu-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    scale_in_cooldown  = 1024
    scale_out_cooldown = 1024
    target_value       = 70
  }
}