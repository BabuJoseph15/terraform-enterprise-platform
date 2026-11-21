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
