#!/bin/bash

# Script to set up GitHub remote and push changes

# Check if GitHub repository URL is provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 <github_repo_url> [branch_name]"
  echo "Example: $0 https://github.com/username/repo.git main"
  exit 1
fi

GITHUB_REPO_URL=$1
BRANCH_NAME=${2:-main}  # Default to 'main' if not provided

# Configure Git if not already configured
if [ -z "$(git config --get user.name)" ]; then
  echo "Configuring Git user name..."
  read -p "Enter your Git user name: " GIT_USER_NAME
  git config --global user.name "$GIT_USER_NAME"
fi

if [ -z "$(git config --get user.email)" ]; then
  echo "Configuring Git user email..."
  read -p "Enter your Git user email: " GIT_USER_EMAIL
  git config --global user.email "$GIT_USER_EMAIL"
fi

# Check if we're in a Git repository
if [ ! -d .git ]; then
  echo "Not in a Git repository. Initializing..."
  git init
  git add .
  git commit -m "Initial commit"
fi

# Add GitHub remote
if git remote | grep -q "github"; then
  echo "GitHub remote already exists. Updating URL..."
  git remote set-url github "$GITHUB_REPO_URL"
else
  echo "Adding GitHub remote..."
  git remote add github "$GITHUB_REPO_URL"
fi

# Create branch if it doesn't exist
if ! git branch | grep -q "$BRANCH_NAME"; then
  echo "Creating branch $BRANCH_NAME..."
  git checkout -b "$BRANCH_NAME"
else
  echo "Switching to branch $BRANCH_NAME..."
  git checkout "$BRANCH_NAME"
fi

# Pull latest changes to avoid conflicts (if the remote branch exists)
echo "Attempting to pull latest changes from GitHub..."
git pull github "$BRANCH_NAME" --rebase || echo "Remote branch doesn't exist yet or couldn't pull."

# Push changes to GitHub
echo "Pushing changes to GitHub..."
git push -u github "$BRANCH_NAME"

echo "Done! Your code has been pushed to GitHub at $GITHUB_REPO_URL on branch $BRANCH_NAME."