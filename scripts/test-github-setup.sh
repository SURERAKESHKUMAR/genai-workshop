#!/bin/bash

# Script to test GitHub integration setup

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're in a Git repository
if [ ! -d .git ]; then
    echo "Error: Not in a Git repository. Please run this script from the root of your Git repository."
    exit 1
fi

# Check if GitHub remote exists
if ! git remote | grep -q "github"; then
    echo "Error: GitHub remote not found. Please run the setup-github.sh script first."
    echo "Example: ./scripts/setup-github.sh https://github.com/username/repo.git main"
    exit 1
fi

# Get GitHub remote URL
GITHUB_URL=$(git remote get-url github)
echo "GitHub remote URL: $GITHUB_URL"

# Check if GitHub Actions workflow file exists
if [ ! -f .github/workflows/push-to-github.yml ]; then
    echo "Error: GitHub Actions workflow file not found."
    exit 1
fi

echo "GitHub Actions workflow file found: .github/workflows/push-to-github.yml"

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: $CURRENT_BRANCH"

echo "GitHub integration setup looks good!"
echo ""
echo "To push your changes to GitHub, you can:"
echo "1. Use the setup script: ./scripts/setup-github.sh $GITHUB_URL $CURRENT_BRANCH"
echo "2. Use Git commands directly: git push -u github $CURRENT_BRANCH"
echo ""
echo "After pushing to GitHub, the GitHub Actions workflow will run automatically."