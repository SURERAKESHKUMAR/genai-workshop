# Terraform ECS Infrastructure

This repository contains Terraform code to deploy an Amazon ECS (Elastic Container Service) infrastructure following best practices such as code modularity and state management.

## Project Structure

```
.
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── providers.tf            # Provider configuration
├── backend.tf              # State management configuration
├── versions.tf             # Terraform and provider versions
├── modules/                # Reusable modules
│   ├── vpc/                # VPC network infrastructure
│   ├── ecs/                # ECS cluster, service, task definition
│   └── security/           # Security groups, IAM roles
├── environments/           # Environment-specific configurations
│   ├── dev/                # Development environment
│   └── prod/               # Production environment
├── .github/workflows/      # GitHub Actions workflows
│   └── push-to-github.yml  # Workflow for pushing to GitHub
├── scripts/                # Utility scripts
│   ├── setup-github.sh     # Script to set up GitHub remote
│   ├── test-github-setup.sh # Script to test GitHub setup
│   └── make-scripts-executable.sh # Script to make all scripts executable
├── docs/                   # Documentation
│   └── github-integration.md # GitHub integration guide
└── test/                   # Test scripts
    └── validate.sh         # Validation script
```

## Prerequisites

- Terraform v1.0.0+
- AWS CLI configured with appropriate credentials
- S3 bucket for remote state storage
- DynamoDB table for state locking
- Git installed locally

## Usage

### Initialize the project

```bash
terraform init
```

### Plan the deployment

```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

### Apply the changes

```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

### Destroy the infrastructure

```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## State Management

This project uses remote state management with an S3 backend and DynamoDB for state locking. Configure the backend.tf file with your specific S3 bucket and DynamoDB table.

## GitHub Integration

This repository includes tools to help you push your changes to GitHub:

### Using the Setup Script

1. Create a repository on GitHub (if you haven't already)
2. Run the setup script with your GitHub repository URL:

```bash
# Make the script executable
chmod +x scripts/setup-github.sh

# Run the script with your GitHub repository URL
./scripts/setup-github.sh https://github.com/username/repo.git main
```

The script will:
- Configure Git if needed
- Add your GitHub repository as a remote
- Push your code to the specified branch

### Using GitHub Actions

This repository includes a GitHub Actions workflow that can be used to push changes to GitHub:

1. First, push your code to GitHub using the setup script
2. Make your changes
3. The workflow will automatically run when you push to the main branch
4. You can also manually trigger the workflow from the GitHub Actions tab

### Manual Git Commands

If you prefer to use Git commands directly:

```bash
# Add GitHub remote
git remote add github https://github.com/username/repo.git

# Push changes to GitHub
git push -u github main
```

For detailed instructions, see:
- [GitHub Integration Guide](docs/github-integration.md)
- [GitHub Usage Guide](USAGE-GITHUB.md)

## Modules

### VPC Module

Creates a VPC with public and private subnets across multiple availability zones.

### ECS Module

Sets up an ECS cluster, task definitions, and services.

### Security Module

Configures security groups and IAM roles required for the ECS infrastructure.