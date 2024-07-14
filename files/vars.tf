variable "access_key" {
  default     = "ASIARL2CKF6RZJXA7JWB"
}

variable "secret_key" {
  default     = "tJCOIVTdp0TcYiz8YAJTjkgVl3fqJRYg0Cu6w0SJ"
}

variable "token" {
  default = "IQoJb3JpZ2luX2VjEOT//////////wEaCXVzLXdlc3QtMiJGMEQCIFxh185WaCjh7Avw7cjVYPNHpUujrxfWL7Ylem1DqSP1AiAQWxs8AqI6GgECo/OBn4ee7NYy80e8LV+8xxamYwLGeiq+Agit//////////8BEAIaDDA5NDA5MTQ4OTE4NyIM/oR0JH0tLe+li3/3KpICO0GqtZ59EWEpkyEtZi76CUU2+/dwgAO0JaOmL86Zz0jYyvpjm8k4FFsq3NPYDgDWLi0K5ELMStwBippfwDkDcjp594jLUhA3BEacKFRZOi2XE2Vw1YDJMJuJjRqlNPJkJUwNzYBOyiNshWqJDsplkyifUN5tD+HzL5sUXqFIZ0h6IuvELeVyoJ5OcbX1e3EQhMAJ61PHCS/alWjF+oUiPkZlRclg1yycw/mnVKez1QfuJL7B4gZeX+/DbAGi6yw6HDW45q5HF3MG1QjTJ4YX7DaNWztghYoh5J7/Opb57A/PrxsULYdsalCQehpvzDlqX9MvfPy3mylD/g5+xtqyn6XBLjpkKwWRaTicUYrILT4D/DCs2tC0BjqeAa7gK4iltEJt5XuGaJABlnvjtEENhtXqbdHDmB+ewckgqrtZ2d/01dNUzg0EZy1LtrOAXhghfPctwUoXwiC4WqCN40dz4thnMGEfmn05SXSMwKAlALi/GBbtUV0Q2+mzh/apvM8Vuj4GohbPJX2GmWymLY40vJ8su0WVBd+XdpSBwE3oezqz70Xv9K83bAtU6eH7VeZ+Eb3YwEAiEPBC"
}

variable "labRole" {
  default = "arn:aws:iam::094091489187:role/LabRole"
}

variable "principalArn" {
    default = "arn:aws:iam::094091489187:role/voclabs"
}

variable "ecsTaskDefinition" {
  default = "arn:aws:iam::094091489187:role/ecsTaskExecutionRole"
}

variable "mongodb" {
  default = "mongodb+srv://admin:fiap_fase3@restaurante-prod-cluste.rkutlhb.mongodb.net/?retryWrites=true&w=majority&appName=restaurante-prod-cluster"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}
variable "sgId" {
  default = "sg-01379b3d488d94d68"
}

variable "accessConfig" {
  default = "API_AND_CONFIG_MAP"
}

variable "nodeName" {
  default = "node-fiap"
}

variable "region" {
  default     = "us-east-1"
}

# networking
variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# load balancer
variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

variable "amis" {
  description = "Which AMI to spawn."
  default = {
    us-east-1 = "ami-05fa00d4c63e32376"
    us-east-2 = "ami-0568773882d492fc8"
  }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "eks_instance_name" {
  description = "Name of the EKS instance"
  default     = "restaurante-eks"
}


# key pair - Location to the SSH Key generate using openssl or ssh-keygen or AWS KeyPair
variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/aws/aws_key.pub"
}


# auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of EKS)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EKS)"
  default     = "3"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EKS)"
  default     = "1"
}