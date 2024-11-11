# Spring Boot MySQL Deployment Workflow Documentation

## Overview

This GitHub Actions workflow automates security scanning, building, and deploying a Spring Boot MySQL application to Azure Kubernetes Service (AKS).

## Workflow Triggers

```yaml
on:
  workflow_dispatch      # Manual trigger
  push:
    branches: [ main ]
    paths:
      - 'apps/springboot-mysql/**'  # Only run on changes to MySQL app
```

## Jobs

### 1. Security Checks Job

Performs security scanning and vulnerability assessment:

```yaml
security-checks:
  runs-on: ubuntu-latest
  environment: dev
```

Key steps:

- OWASP Dependency Check scanning
- Trivy container vulnerability scanning
- Uploads security reports as artifacts
- Reports vulnerabilities to GitHub Security tab

### 2. Build and Deploy Job

Handles application building and deployment:

```yaml
build-and-deploy:
  needs: security-checks
  runs-on: ubuntu-latest
  environment: dev
```

Key steps:

1. **Environment Setup**

   - Java 17 setup
   - Node.js 16 setup
   - Azure authentication
   - ACR authentication

2. **Application Build**
   - Build backend with Maven
   - Environment variables configured for MySQL
   - Skip tests during build

3. **Container Management**
   - Build Docker image
   - Push to Azure Container Registry
   - Uses `latest` tag

4. **Deployment**
   - Set AKS context
   - Deploy to Kubernetes cluster

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

### MySQL Configuration

- `MYSQL_SERVER_NAME`
- `MYSQL_DATABASE`
- `MYSQL_USERNAME`
- `MYSQL_PASSWORD`

## Security Features

- OWASP dependency scanning
- Trivy container scanning
- Scans for CRITICAL and HIGH severity vulnerabilities
- Results uploaded to GitHub Security tab
- Continues on scan errors with `continue-on-error: true`

## Environment Variables

The build process requires MySQL configuration through environment variables:
```yaml

env:
  MYSQL_SERVER_NAME: ${{ secrets.MYSQL_SERVER_NAME }}
  MYSQL_DATABASE: ${{ secrets.MYSQL_DATABASE }}
  MYSQL_USERNAME: ${{ secrets.MYSQL_USERNAME }}
  MYSQL_PASSWORD: ${{ secrets.MYSQL_PASSWORD }}
```

## Notes

- Uses Java 17 with Temurin distribution
- Node.js 16 for frontend components
- Skips tests during build phase
- Uses latest tag for container versioning
- Requires pre-configured AKS cluster
- Security scans are non-blocking but reported

## Dependencies

- `actions/checkout@v3`
- `actions/setup-java@v3`
- `actions/setup-node@v3`
- `azure/login@v2`
- `azure/cli@v2`
- `azure/docker-login@v1`
- `azure/aks-set-context@v2`
- `aquasecurity/trivy-action@0.28.0`
- `github/codeql-action/upload-sarif@v3`