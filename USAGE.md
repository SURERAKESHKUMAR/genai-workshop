# Terraform ECS Infrastructure Usage Guide

This guide explains how to use the Terraform ECS infrastructure modules to deploy your containerized applications on AWS ECS.

## Architecture Overview

This Terraform project creates the following AWS resources:

- **VPC** with public and private subnets across multiple availability zones
- **NAT Gateways** for outbound internet access from private subnets
- **ECS Cluster** to host containerized applications
- **ECS Service** to run and maintain a specified number of instances of a task definition
- **ECS Task Definition** that specifies the container configuration
- **Application Load Balancer (ALB)** to distribute traffic to the ECS service
- **Security Groups** to control inbound and outbound traffic
- **IAM Roles** for ECS task execution and task roles
- **CloudWatch Log Group** for container logs
- **Auto Scaling** policies based on CPU and memory utilization

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) v1.0.0 or newer
2. AWS CLI configured with appropriate credentials
3. S3 bucket for remote state storage
4. DynamoDB table for state locking

## Getting Started

### 1. Configure the Backend

Edit the `backend.tf` file to specify your S3 bucket and DynamoDB table for state management:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "ecs-infrastructure/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

### 2. Choose an Environment

The project supports multiple environments (dev, prod). Choose the appropriate environment by specifying the tfvars file:

```bash
# For development environment
terraform plan -var-file=environments/dev/terraform.tfvars

# For production environment
terraform plan -var-file=environments/prod/terraform.tfvars
```

### 3. Customize Variables

Edit the environment-specific `terraform.tfvars` files to customize your deployment:

- `aws_region`: AWS region to deploy resources
- `environment`: Environment name (e.g., dev, staging, prod)
- `project_name`: Name of the project
- `vpc_cidr`: CIDR block for the VPC
- `availability_zones`: List of availability zones to use
- `ecs_cluster_name`: Name of the ECS cluster
- `container_image`: Docker image to run in the ECS task
- `container_port`: Port exposed by the container
- `desired_count`: Desired number of tasks running
- `cpu`: CPU units for the task
- `memory`: Memory for the task in MiB

### 4. Deploy the Infrastructure

Initialize Terraform:

```bash
terraform init
```

Plan the deployment:

```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

Apply the changes:

```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

### 5. Clean Up

To destroy the infrastructure:

```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## Module Usage

### VPC Module

```hcl
module "vpc" {
  source = "./modules/vpc"

  vpc_name           = "my-vpc"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  environment        = "dev"
}
```

### Security Module

```hcl
module "security" {
  source = "./modules/security"

  vpc_id       = module.vpc.vpc_id
  environment  = "dev"
  project_name = "my-project"
  container_port = 80
}
```

### ECS Module

```hcl
module "ecs" {
  source = "./modules/ecs"

  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_subnet_ids   = module.vpc.public_subnet_ids
  ecs_cluster_name    = "my-cluster"
  container_image     = "nginx:latest"
  container_port      = 80
  desired_count       = 2
  cpu                 = 256
  memory              = 512
  environment         = "dev"
  project_name        = "my-project"
  ecs_task_execution_role_arn = module.security.ecs_task_execution_role_arn
  ecs_task_role_arn   = module.security.ecs_task_role_arn
  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id
}
```

## Best Practices

1. **State Management**: Always use remote state with locking to prevent concurrent modifications.
2. **Code Modularity**: Use modules to organize and reuse infrastructure code.
3. **Environment Separation**: Maintain separate configurations for different environments.
4. **Security**: Follow the principle of least privilege for IAM roles and security groups.
5. **Tagging**: Use consistent tagging for all resources for better organization and cost tracking.
6. **Auto Scaling**: Configure appropriate scaling policies based on your application's needs.
7. **Monitoring**: Set up CloudWatch alarms for important metrics.

## Troubleshooting

1. **Terraform Init Fails**: Ensure your AWS credentials have access to the S3 bucket and DynamoDB table.
2. **ECS Service Fails to Start**: Check the CloudWatch logs for the ECS service.
3. **Load Balancer Health Checks Failing**: Verify the container is listening on the specified port and the health check path is correct.