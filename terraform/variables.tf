variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
}
variable "app_port" {
  type    = number
  default = 8501
}
variable "container_port" {
  description = "Application container port"
  type        = number
  default     = 8501
}

variable "desired_count" {
  description = "ECS task count"
  type        = number
  default     = 1
}
