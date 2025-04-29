# Development Environment Variables

aws_region         = "us-east-1"
environment        = "dev"
project_name       = "ecs-app"
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
ecs_cluster_name   = "app-cluster"
container_image    = "nginx:latest"
container_port     = 80
desired_count      = 2
cpu                = 256
memory             = 512