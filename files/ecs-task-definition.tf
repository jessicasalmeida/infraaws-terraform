resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "restaurante-ecs-task"
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
      name         = "cart"
      image        = "094091489187.dkr.ecr.us-east-1.amazonaws.com/cart"
      cpu          = 1024
      memory       = 2048
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
          value = aws_db_instance.cart_db.address
        },
        {
          name  = "DB_NAME"
          value = "postgres"
        },
        {
          name  = "DB_USER"
          value = "postgres"
        },
        {
          name  = "DB_PASSWORD"
          value = "fiapfase4!"
        },
        {
          name  = "ORDER_SERVER"
          value = "http://${aws_lb.admin-lb.dns_name}"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_api.main.api_endpoint
        }
      ]
    }
  ])
}
