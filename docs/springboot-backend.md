# Backend Deployment Documentation

## Overview

This Kubernetes configuration defines the deployment setup for a Spring Boot backend service running in Azure Kubernetes Service (AKS).

## Components

### 1. Deployment

```yaml
kind: Deployment
metadata:
  name: backend-deployment
```

- Maintains 2 replicas for high availability
- Uses container image from Azure Container Registry
- Resource constraints configured:
  - Requests: 64Mi memory, 250m CPU
  - Limits: 128Mi memory, 500m CPU
- Exposes port 8080

### 2. Service

```yaml
kind: Service
metadata:
  name: backend-service
```

- Standard ClusterIP service type
- Exposes port 8080 internally
- Routes traffic to pods with label `app: backend`
- Used by frontend to access backend API

## Resource Management

- CPU and memory limits prevent resource exhaustion:
  - Minimum guaranteed resources (requests)
  - Maximum allowed resources (limits)
- Two replicas ensure availability during updates

## Configuration Requirements

- Requires secret `ACR_LOGIN_SERVER` for image repository
- Application must listen on port 8080
- Pods must pass readiness/liveness probes (if configured)

## Deployment

```sh
kubectl apply -f backend-deployment.yaml
```

## Notes

- Service discovery uses label selector `app: backend`
- No external access - only accessible within cluster
- Designed to work with frontend service through internal networking
- Resource limits should be adjusted based on actual application needs