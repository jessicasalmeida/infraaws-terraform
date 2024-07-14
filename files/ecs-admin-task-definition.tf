resource "aws_ecs_task_definition" "ecs_admin_task_definition" {
  family                   = "admin-restaurante-ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = var.labRole
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name         = "admin"
      image        = aws_ecr_repository.repository_admin.repository_url
      cpu          = 1024
      memory       = 2048
      essential    = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/order-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "order-service"
        }
      }
      environment = [
        {
          name  = "DB_CONN_STRING"
          value = var.mongodb
        },
        {
          name  = "DB_NAME"
          value = "restaurante_db"
        },
        {
          name  = "ORDER_COLLECTION_NAME"
          value = "order"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_api.main.api_endpoint
        }
      ]
    }
  ])
}