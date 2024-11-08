# Frontend Deployment Documentation

## Overview

This Kubernetes configuration defines the deployment setup for a frontend application running in AKS (Azure Kubernetes Service).

## Components

### 1. Deployment

```yaml
kind: Deployment
metadata:
  name: frontend-deployment
```

- Maintains 2 replicas
- Uses container image from Azure Container Registry
- Resource constraints:
  - Requests: 64Mi memory, 250m CPU
  - Limits: 128Mi memory, 500m CPU
- Exposes port 80

### 2. Service

```yaml
kind: Service
metadata:
  name: frontend-service
```

- Type: LoadBalancer
- Exposes port 80
- Routes traffic to pods with label `app: frontend`

### 3. Ingress

```yaml
kind: Ingress
metadata:
  name: springboot-ingress
```

- Uses NGINX ingress controller
- Configures routing rules:
  - Frontend: `/*` → `frontend-service:80`
  - Backend API: `/api/*` → `backend-service:8080`
- TLS enabled with Let's Encrypt certificates
- URL rewriting enabled

## Security

- HTTPS enabled via cert-manager
- TLS certificates managed by Let's Encrypt
- Uses secret `your-tls-secret` for TLS

## Deployment

```sh
kubectl apply -f frontend-deployment.yaml
```

## Requirements

- NGINX Ingress Controller installed
- cert-manager configured
- Secret `ACR_LOGIN_SERVER` configured
- Domain configured in secrets
- Let's Encrypt ClusterIssuer configured

## Notes

- Uses LoadBalancer service type for external access
- Implements path-based routing for frontend and API requests
- Automatic SSL certificate management through cert-manager