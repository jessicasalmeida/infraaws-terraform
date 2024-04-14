variable "labRole" {
  default = "arn:aws:iam::094091489187:role/LabRole"
}

variable "principalArn" {
  default = "arn:aws:iam::094091489187:role/voclabs"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}
variable "subnetA" {
  default = "subnet-0910b2fd9e6178349"
}

variable "subnetB" {
  default = "subnet-005c35d75e647c5d4"
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