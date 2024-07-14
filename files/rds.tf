resource "aws_db_instance" "cart_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  db_name              = "postgres"
  username             = "postgres"
  password             = "fiapfase4!"
  parameter_group_name = "teste"
  port = "5432"
  skip_final_snapshot  = true
  apply_immediately = true
  publicly_accessible = true

  # Configurações de VPC e Subnet
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.restaurante_sg.id]

  # Tags (opcional)
  tags = {
    Name = "cart_db"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "mydbsubnetgroup"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  tags = {
    Name = "MyDBSubnetGroup"
  }
}

# Saída da senha gerada
output "db_endpoins" {
  value       = aws_db_instance.cart_db.address
  description = "The endpoint for the RDS instance"
}

resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "postgres16"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}