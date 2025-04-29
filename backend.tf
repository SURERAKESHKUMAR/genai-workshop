terraform {
  backend "s3" {
    # Replace these values with your own
    bucket         = "your-terraform-state-bucket"
    key            = "ecs-infrastructure/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

# Note: You can also use a partial configuration and provide the values at runtime:
# terraform init -backend-config="bucket=your-bucket" -backend-config="key=your-key" -backend-config="region=your-region" -backend-config="dynamodb_table=your-table"