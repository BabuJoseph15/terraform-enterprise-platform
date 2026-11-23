variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "container_port" {
  type    = number
  default = 8501
}

variable "desired_count" {
  type    = number
  default = 1
}
variable "target_group_arn" {
  type = string
}
