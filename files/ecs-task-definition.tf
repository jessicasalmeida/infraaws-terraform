resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "restaurante-ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = var.labRole
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name         = "restaurante"
      image        = aws_ecr_repository.repository_terraform.repository_url
      cpu          = 512
      memory       = 1024
      essential    = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/restaurante-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "restaurante"
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
          name  = "CART_COLLECTION_NAME"
          value = "cart"
        },
        {
          name  = "ORDER_COLLECTION_NAME"
          value = "order"
        },
        {
          name  = "PRODUCT_COLLECTION_NAME"
          value = "produtos"
        },
        {
          name  = "USER_COLLECTION_NAME"
          value = "user"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_stage.example.invoke_url
        }
      ]
    }
  ])
}
