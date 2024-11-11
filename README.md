# Project Onboarding Documentation

## Prerequisites

- Azure CLI installed
- Docker installed
- Kubectl installed
- Helm installed
- Terraform installed
- Just command runner installed
- Access to Azure subscription

## Environment Configuration

### Initial Setup

1. **Azure Login and Subscription Setup**

```sh
just login
```

2. **Connect to AKS Cluster**

```sh
just aks-credentials
```

## Application Deployment

### 1. Build and Push Images

```sh
# Build Docker images for frontend and backend
just docker-build

# Push images to Azure Container Registry
just docker-push
```

### 2. Deploy Applications

```sh
# Deploy all applications to Kubernetes
just k8s-deploy
```

### 3. Install NGINX Ingress Controller

```sh
just install-nginx-ingress
```

## Infrastructure Management

### GitHub Infrastructure

```sh
# Initialize Terraform
just gh-tf-init

# Plan changes
just gh-tf-plan

# Apply changes
just gh-tf-apply

# Cleanup
just gh-tf-destroy
```

### Azure Cluster Infrastructure

```sh
# Initialize Terraform
just cs-tf-init

# Plan changes
just cs-tf-plan

# Apply changes
just cs-tf-apply

# Cleanup
just cs-tf-destroy
```

## Monitoring and Maintenance

### View Kubernetes Resources

```sh
# List all pods
just get-pods

# List all services
just get-services

# List all deployments
just get-deployments
```

## Quick Commands

### Complete Deployment Pipeline

```sh
just deploy
```

### Cleanup Resources

```sh
just cleanup
```

## Key Configuration

- **Azure Container Registry:** `devacrfcaks.azurecr.io`
- **AKS Cluster Name:** `dev-fcaks`
- **Resource Group:** `rg-fc-aks`

## Application Architecture

### Security

- HTTPS enabled through cert-manager
- Authentication configured for backend services
- NGINX Ingress handles routing and TLS termination

## Additional Notes

- All deployments are managed through Kubernetes manifests
- Infrastructure is managed through Terraform
- CI/CD is handled through GitHub Actions
- Commands are centralized in the
