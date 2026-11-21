output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "aws_region" {
  value = var.aws_region
}

output "environment" {
  value = var.environment
}
output "alb_security_group_id" {
  value = module.security.alb_security_group_id
}

output "ecs_security_group_id" {
  value = module.security.ecs_security_group_id
}

output "efs_security_group_id" {
  value = module.security.efs_security_group_id
}
