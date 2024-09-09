resource "aws_ecs_task_definition" "ecs_payment_task_definition" {
  family                   = "payment-restaurante-ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = var.labRole
  requires_compatibilities = ["FARGATE"]
  cpu                      = 2048
  memory                   = 4096

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name         = "payment"
      image        = aws_ecr_repository.repository_payment.repository_url
      cpu          = 2048
      memory       = 4000
      essential    = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/payment-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "payment-service"
        }
      }
      environment = [
        {
          name  = "DB_CONN_STRING"
          value = var.mongodb
        },
        {
          name  = "DB_NAME"
          value = "payment"
        },
        {
          name  = "PAYMENT_COLLECTION_NAME"
          value = "payment"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_api.main.api_endpoint
        },
        {
          name = "MQ_CONN_STRING"
          value = "amqp://guest:guest@${aws_lb.rabbit-lb.dns_name}:5672"
        }
      ]
    }
  ])
}