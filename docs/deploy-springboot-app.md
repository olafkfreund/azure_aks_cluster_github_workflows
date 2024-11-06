# Spring Boot Application Deployment Workflow

## Overview

This GitHub Actions workflow automates the build and deployment process of a Spring Boot application with a React frontend to Azure Kubernetes Service (AKS).

## Workflow Triggers

- Manual trigger using `workflow_dispatch`
- (Commented out) Automatic trigger on pushes to main branch

## Environment Requirements

### Azure Resources

- Azure Kubernetes Service (AKS) cluster
- Azure Container Registry (ACR)

### Required Secrets

- `AZURE_CREDENTIALS`: Azure service principal credentials
- `ACR_LOGIN_SERVER`: Azure Container Registry server URL
- `ACR_USERNAME`: ACR login username
- `ACR_PASSWORD`: ACR login password
- `AKS_CLUSTER_NAME`: Name of the AKS cluster
- `AKS_RESOURCE_GROUP`: Resource group containing the AKS cluster

## Workflow Steps

### 1. Setup Environment

```yaml
- uses: actions/checkout@v3
- uses: actions/setup-java@v3
  with:
    java-version: '17'
- uses: actions/setup-node@v3
  with:
    node-version: '16'
```

### 2. Build Applications

```yaml
# Backend Build
- run: mvn clean package -DskipTests
  working-directory: backend

# Frontend Build
- run: |
    npm install
    npm run build
  working-directory: frontend
```

### 3. Container Image Management

```yaml
# Build and push backend image
- run: |
    docker build -t $ACR_LOGIN_SERVER/backend:${{ github.sha }} ./backend
    docker login $ACR_LOGIN_SERVER
    docker push $ACR_LOGIN_SERVER/backend:${{ github.sha }}

# Build and push frontend image
- run: |
    docker build -t $ACR_LOGIN_SERVER/frontend:${{ github.sha }} ./frontend
    docker login $ACR_LOGIN_SERVER
    docker push $ACR_LOGIN_SERVER/frontend:${{ github.sha }}
```

### 4. AKS Deployment

```yaml
# Set AKS context
- uses: azure/aks-set-context@v2

# Update deployments
- run: |
    kubectl set image deployment/backend-deployment backend=$ACR_LOGIN_SERVER/backend:${{ github.sha }}
    kubectl set image deployment/frontend-deployment frontend=$ACR_LOGIN_SERVER/frontend:${{ github.sha }}
```

## Prerequisites

- Existing Kubernetes deployments named `backend-deployment` and `frontend-deployment`
- Azure credentials with permissions to:
  - Push to ACR
  - Deploy to AKS
  - Update Kubernetes deployments

## Notes

- Uses container image tags based on GitHub commit SHA
- Skips backend tests during build (`-DskipTests`)
- Both frontend and backend services must be pre-deployed to AKS