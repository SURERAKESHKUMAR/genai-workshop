provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

terraform {
  backend "s3" {
    # These values should be provided via backend-config or terraform init command
    key = "ecs-infrastructure/dev/terraform.tfstate"
  }
}

module "ecs_infrastructure" {
  source = "../../root-module"

  # Pass all variables to the root module
  aws_region         = var.aws_region
  environment        = var.environment
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  ecs_cluster_name   = var.ecs_cluster_name
  container_image    = var.container_image
  container_port     = var.container_port
  desired_count      = var.desired_count
  cpu                = var.cpu
  memory             = var.memory
}