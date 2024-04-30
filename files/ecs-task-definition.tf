resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "restaurante-ecs-task"
  network_mode       = "awsvpc"
  execution_role_arn = var.labRole
  requires_compatibilities = ["FARGATE"]
  cpu                = 512
  memory             = 1024

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "restaurante"
      image     = "590183826114.dkr.ecr.us-east-1.amazonaws.com/restaurante:latest"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DB_CONN_STRING"
          value = "mongodb://root:MongoDB2019!@mongo:27017/"
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
        }
      ]
    }
  ])
}
