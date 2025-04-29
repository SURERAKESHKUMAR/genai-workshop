output "vpc_id" {
  description = "ID of the VPC"
  value       = module.ecs_infrastructure.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.ecs_infrastructure.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.ecs_infrastructure.private_subnets
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs_infrastructure.ecs_cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs_infrastructure.ecs_cluster_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs_infrastructure.ecs_service_name
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = module.ecs_infrastructure.load_balancer_dns
}