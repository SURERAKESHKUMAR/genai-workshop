#!/bin/bash

# Test script to validate Terraform configuration and GitHub integration

# Set error handling
set -e

echo "Running validation tests..."

# Change to the root directory
cd "$(dirname "$0")/.."

# Initialize Terraform (with a dummy backend)
echo "Initializing Terraform..."
terraform init -backend=false

# Validate the Terraform configuration
echo "Validating Terraform configuration..."
terraform validate

# Format check
echo "Checking Terraform formatting..."
terraform fmt -check -recursive

# Check GitHub integration setup
echo "Checking GitHub integration setup..."

# Check if GitHub Actions workflow file exists
if [ -f .github/workflows/push-to-github.yml ]; then
  echo "✅ GitHub Actions workflow file found"
else
  echo "❌ GitHub Actions workflow file not found"
  exit 1
fi

# Check if GitHub integration scripts exist
if [ -f scripts/setup-github.sh ] && [ -f scripts/test-github-setup.sh ]; then
  echo "✅ GitHub integration scripts found"
else
  echo "❌ GitHub integration scripts not found"
  exit 1
fi

# Check if GitHub integration documentation exists
if [ -f docs/github-integration.md ]; then
  echo "✅ GitHub integration documentation found"
else
  echo "❌ GitHub integration documentation not found"
  exit 1
fi

echo "All tests passed successfully!"