variable "userPoolClientId" {
  default = "4e69npdo4oi4rtkjo7ir2gqf3k"
}

variable "userPoolEndPoint" {
  default = "https://cognito-idp.us-east-1.amazonaws.com/us-east-1_rNjKaVPCB"
}

variable "lambdaLoginArn" {
  default = "arn:aws:lambda:us-east-1:094091489187:function:login"
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
  default = "mongodb+srv://admin:fiap_fase3@restaurante-prod-cluste.tcrs6sj.mongodb.net/?retryWrites=true&w=majority&appName=restaurante-prod-cluster"
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