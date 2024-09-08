resource "aws_ecs_task_definition" "ecs_rabbitmq_task_definition" {
  family                   = "rabbitmq-restaurante-ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = var.labRole
  requires_compatibilities = ["FARGATE"]
  cpu                      = 8192
  memory                   = 32768

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name         = "rabbitmq"
      image        = "public.ecr.aws/docker/library/rabbitmq:3-management"
      cpu          = 4096
      memory       = 8000
      essential    = true
      portMappings = [
        {
          containerPort = 5672
          hostPort      = 5672
          protocol      = "tcp"
        },
        {
          containerPort = 15672
          hostPort      = 15672
          protocol      = "tcp"
        },
        {
          containerPort = 25676
          hostPort      = 25676
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/rabbitmq-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "rabbitmq-service"
        }
      }
    }
  ])
}