locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name            = "${local.name_prefix}-vpc"
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  environment         = var.environment
}

module "security" {
  source = "./modules/security"

  vpc_id              = module.vpc.vpc_id
  environment         = var.environment
  project_name        = var.project_name
  container_port      = var.container_port
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_subnet_ids   = module.vpc.public_subnet_ids
  ecs_cluster_name    = "${local.name_prefix}-${var.ecs_cluster_name}"
  container_image     = var.container_image
  container_port      = var.container_port
  desired_count       = var.desired_count
  cpu                 = var.cpu
  memory              = var.memory
  environment         = var.environment
  project_name        = var.project_name
  ecs_task_execution_role_arn = module.security.ecs_task_execution_role_arn
  ecs_task_role_arn   = module.security.ecs_task_role_arn
  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id
}