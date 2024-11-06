# .NET Application Deployment to AKS Workflow

## Overview

This GitHub Actions workflow automates building and deploying a .NET application to Azure Kubernetes Service (AKS).

## Workflow Triggers

- Manual trigger via `workflow_dispatch`
- (Commented out) Automatic trigger on pushes to main branch

## Workflow Structure

The workflow consists of two jobs:

### 1. Build Job

Builds and pushes the Docker image to Azure Container Registry (ACR)

```yaml
steps:
- Checkout code
- Setup Docker Buildx
- Login to ACR
- Build and push Docker image with tag 'latest'
```

### 2. Deploy Job

Deploys the application to AKS and runs integration tests

```yaml
steps:
- Deploy to AKS cluster
- Run integration tests using pytest
```

## Required Secrets

- `ACR_LOGIN_SERVER`: Azure Container Registry server URL
- `ACR_USERNAME`: ACR login username 
- `ACR_PASSWORD`: ACR login password
- `AZURE_CLIENT_ID`: Service principal client ID
- `AZURE_CLIENT_SECRET`: Service principal secret
- `AZURE_TENANT_ID`: Azure tenant ID
- `AKS_RESOURCE_GROUP`: Resource group containing AKS cluster
- `AKS_CLUSTER_NAME`: Name of the AKS cluster

## Prerequisites

- Azure Kubernetes Service cluster
- Azure Container Registry
- Service Principal with permissions to:
  - Push to ACR
  - Deploy to AKS
- Kubernetes manifest file (`deployment.yml`)
- Integration tests in `./test/integration_tests.py`

## Testing

The workflow includes automated integration testing:

- Installs pytest and Kubernetes Python packages
- Runs integration tests after deployment
- Tests must be located in `./test/integration_tests.py`

## Notes

- Uses Docker Buildx for optimized container builds
- Includes deployment status verification
- Integration tests run as part of the deployment pipeline
- Uses the `latest` tag for Docker images

## Dependencies

- `azure/docker-login@v1`: For ACR authentication
- `azure/cli@v1`: For Azure CLI operations
- Python with pytest for testing