# Justfile Documentation

## Variables

```just
set dotenv-load
registry := "devacrfcaks.azurecr.io"
aks_name := "dev-fcaks"
rg := "rg-fc-aks"
resource_group_name := "rg-fcaks-tfstate"
storage_account_name := "fcdevfstate"
container_name := "tfstate"
```

## Authentication Commands

```just
login                 # Login to Azure and set subscription
aks-credentials       # Get AKS cluster credentials
```

## Docker Commands

```just
docker-build         # Build Docker images for springboot and .NET applications
docker-push          # Login to ACR and push Docker images
```

## Kubernetes Deployment Commands

```just
k8s-deploy-springboot        # Deploy springboot application
k8s-deploy-springboot-mysql  # Deploy springboot with MySQL
k8s-deploy-dotnet           # Deploy .NET application
install-nginx-ingress       # Install NGINX ingress controller
```

## Kubernetes Resource Commands

```just
get-pods              # List all pods
get-services          # List all services
get-deployments       # List all deployments
get-ingress          # List all ingress resources
```

## GitHub Infrastructure Commands

```just
gh-tf-init           # Initialize Terraform for GitHub deployment
gh-tf-plan           # Plan GitHub infrastructure changes
gh-tf-apply          # Apply GitHub infrastructure changes
gh-tf-test           # Run GitHub infrastructure tests
gh-tf-destroy        # Destroy GitHub infrastructure
```

## Azure Infrastructure Commands

```just
cs-tf-init           # Initialize Terraform for cluster deployment
cs-tf-plan           # Plan cluster infrastructure changes
cs-tf-apply          # Apply cluster infrastructure changes
cs-tf-test           # Run cluster infrastructure tests
cs-tf-destroy        # Destroy cluster infrastructure
```

## Pipeline Commands

```just
deploy               # Full deployment pipeline including:
                    # - Azure login
                    # - AKS credentials
                    # - Docker build and push
                    # - All K8s deployments
                    # - NGINX ingress installation

cleanup              # Delete resource group
```

## Usage

1. Setup environment variables in `.env` file
2. Run individual commands with `just <command>`
3. Run full deployment with `just deploy`
4. Clean up resources with `just cleanup`

## Notes

- Requires Azure CLI, Docker, kubectl, and Terraform installed
- Uses Azure Container Registry at `devacrfcaks.azurecr.io`
- Manages both GitHub and Azure cluster infrastructure
- All Terraform commands run from respective directories
- Supports automatic cleanup of resources