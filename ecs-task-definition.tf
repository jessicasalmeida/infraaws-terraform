resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "restaurante-ecs-task"
  network_mode       = "awsvpc"
  execution_role_arn = var.principalArn
  requires_compatibilities = ["FARGATE"]
  cpu                = 256
  memory             = 512
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "restaurante"
      image     = "590183826114.dkr.ecr.us-east-1.amazonaws.com/restaurante:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])
}