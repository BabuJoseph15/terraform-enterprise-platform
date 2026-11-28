module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = var.enable_nat_gateway
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment

  vpc_id   = module.vpc.vpc_id
  app_port = var.app_port
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

module "alb" {
  source = "./modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

  container_port = var.container_port
}

module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name
  environment  = var.environment

  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_security_group_id = module.security.ecs_security_group_id

  ecr_repository_url = module.ecr.repository_url

  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn

  target_group_arn = module.alb.target_group_arn

  container_port = var.container_port
  desired_count  = var.desired_count
}
module "cloudwatch" {
  source = "./modules/cloudwatch"

  project_name = var.project_name
  environment  = var.environment

  ecs_cluster_name = module.ecs.ecs_cluster_name
  ecs_service_name = module.ecs.ecs_service_name

  target_group_arn_suffix  = module.alb.target_group_arn_suffix
  load_balancer_arn_suffix = module.alb.load_balancer_arn_suffix
}
module "cloudwatch_dashboard" {
  source = "./modules/cloudwatch_dashboard"

  project_name = var.project_name
  environment  = var.environment

  ecs_cluster_name = module.ecs.ecs_cluster_name
  ecs_service_name = module.ecs.ecs_service_name

  load_balancer_arn_suffix = module.alb.load_balancer_arn_suffix
  target_group_arn_suffix  = module.alb.target_group_arn_suffix
}
module "github_oidc" {
  source = "./modules/github_oidc"

  project_name = var.project_name
  environment  = var.environment

  github_repository = "BabuJoseph15/terraform-enterprise-platform"
}
