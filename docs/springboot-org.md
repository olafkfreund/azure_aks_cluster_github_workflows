
# Spring Boot Original App Deployment Workflow

## Overview

This GitHub Actions workflow automates the process of building and deploying the original Spring Boot application to Azure Kubernetes Service (AKS).

## Workflow Triggers

- Manual trigger via `workflow_dispatch`
- Automatic trigger on pushes to main branch that modify files in `apps/springboot-org/`

## Permissions

- `id-token: write`: Required for Azure OIDC authentication
- `contents: read`: Required for repository access

## Environment

- Runs on: `ubuntu-latest`  
- Environment: `dev`

## Workflow Steps

### 1. Setup Development Environment

- Checkout code using `actions/checkout@v3`
- Setup Java 17 (Temurin distribution) using `actions/setup-java@v3`
- Setup Node.js 16 using `actions/setup-node@v3`

### 2. Build Application

```yaml
- working-directory: apps/springboot-org
- run: mvn clean package -DskipTests
```

Builds the Spring Boot application while skipping tests

### 3. Azure Authentication & Setup

- Azure login using OIDC with provided credentials
- Verify account access using Azure CLI
- Login to Azure Container Registry (ACR)

### 4. Container Management

```yaml
- Build and tag Docker image: 
  $ACR_LOGIN_SERVER/springboot:latest
- Push image to ACR
```

### 5. Kubernetes Deployment

- Set AKS cluster context
- Deploy application using Kubernetes manifests from `deployment.yml`

## Required Secrets

### Azure Authentication

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

### Container Registry

- `ACR_LOGIN_SERVER`
- `ACR_USERNAME`
- `ACR_PASSWORD`

### Kubernetes

- `AKS_CLUSTER_NAME`
- `AKS_RESOURCE_GROUP`

## Notes

- Uses `latest` tag for Docker images
- Skips tests during build process
- Requires pre-configured AKS cluster
- Requires existing Kubernetes deployment manifests
- Uses workdir `apps/springboot-org` for build and deploy steps

## Dependencies

- `actions/checkout@v3`
- `actions/setup-java@v3` 
- `actions/setup-node@v3`
- `azure/login@v2`
- `azure/cli@v2`
- `azure/docker-login@v1`
- `azure/aks-set-context@v2`
