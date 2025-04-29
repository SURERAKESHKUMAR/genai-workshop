# GitHub Integration Guide

This guide explains how to use the GitHub integration features in this repository to push your changes to GitHub.

## Prerequisites

- Git installed on your local machine
- A GitHub account
- A GitHub repository to push your changes to

## Setup Options

There are three ways to push your changes to GitHub:

1. Using the setup script (recommended for first-time setup)
2. Using GitHub Actions (recommended for ongoing changes)
3. Using Git commands directly (for advanced users)

## Option 1: Using the Setup Script

The setup script automates the process of configuring Git and pushing your changes to GitHub.

### Step 1: Create a GitHub Repository

If you haven't already, create a new repository on GitHub:

1. Go to [GitHub](https://github.com) and sign in
2. Click the "+" icon in the top right corner and select "New repository"
3. Enter a name for your repository
4. Choose whether to make it public or private
5. Do NOT initialize the repository with a README, .gitignore, or license
6. Click "Create repository"

### Step 2: Run the Setup Script

Run the setup script with your GitHub repository URL:

```bash
# Make the script executable
chmod +x scripts/setup-github.sh

# Run the script with your GitHub repository URL
./scripts/setup-github.sh https://github.com/username/repo.git main
```

Replace `username/repo.git` with your actual GitHub username and repository name.

The script will:
- Configure Git if needed
- Add your GitHub repository as a remote
- Push your code to the specified branch

### Step 3: Verify the Setup

You can verify that the setup was successful by running the test script:

```bash
# Make the script executable
chmod +x scripts/test-github-setup.sh

# Run the test script
./scripts/test-github-setup.sh
```

## Option 2: Using GitHub Actions

This repository includes a GitHub Actions workflow that can be used to push changes to GitHub.

### Step 1: Push Your Code to GitHub

First, push your code to GitHub using the setup script (Option 1) or Git commands directly (Option 3).

### Step 2: Configure GitHub Secrets

1. Go to your GitHub repository
2. Click on "Settings" > "Secrets and variables" > "Actions"
3. Click "New repository secret"
4. Name: `GITHUB_REPOSITORY_URL`
5. Value: Your GitHub repository URL (e.g., `https://github.com/username/repo.git`)
6. Click "Add secret"

### Step 3: Trigger the Workflow

You can trigger the workflow manually:

1. Go to your GitHub repository
2. Click on "Actions"
3. Select the "Terraform ECS Infrastructure CI/CD" workflow
4. Click "Run workflow"
5. Enter the branch name and commit message
6. Click "Run workflow"

The workflow will:
- Validate your Terraform code
- Push your changes to the specified branch

## Option 3: Using Git Commands Directly

If you prefer to use Git commands directly:

```bash
# Add GitHub remote
git remote add github https://github.com/username/repo.git

# Push changes to GitHub
git push -u github main
```

Replace `username/repo.git` with your actual GitHub username and repository name.

## Troubleshooting

### Authentication Issues

If you encounter authentication issues when pushing to GitHub:

1. Make sure you have the correct permissions for the repository
2. Try using a personal access token:
   ```bash
   git remote add github https://username:token@github.com/username/repo.git
   ```
   Replace `username` with your GitHub username and `token` with your personal access token

### Merge Conflicts

If you encounter merge conflicts:

1. Pull the latest changes from GitHub:
   ```bash
   git pull github main --rebase
   ```
2. Resolve the conflicts manually
3. Push the changes again:
   ```bash
   git push -u github main
   ```

## Additional Resources

- [GitHub Documentation](https://docs.github.com)
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)