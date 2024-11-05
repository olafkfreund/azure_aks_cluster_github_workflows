# justfile

# Variables
set dotenv-load
registry := "myacr.azurecr.io"
aks_name := "my-aks-cluster"
rg := "my-resource-group"

# Azure Login and Setup
login:
    az login
    az account set --subscription $SUBSCRIPTION_ID

aks-credentials:
    az aks get-credentials --resource-group {{rg}} --name {{aks_name}}

# Docker Build and Push
docker-build:
    docker build -t {{registry}}/backend:latest ./apps/springboot/backend
    docker build -t {{registry}}/frontend:latest ./apps/springboot/frontend

docker-push:
    az acr login --name {{registry}}
    docker push {{registry}}/backend:latest
    docker push {{registry}}/frontend:latest

# Kubernetes Deployments
k8s-deploy:
    kubectl apply -f ./apps/springboot/backend/backend-deployment.yaml
    kubectl apply -f ./apps/springboot/frontend/frontend-deployment.yaml
    kubectl apply -f ./apps/dotnet/aspnet-core-dotnet-core/dotnet-deployment.yaml
    kubectl apply -f ./apps/dotnet/aspnet-core-dotnet-core/ingress.yaml

# Add to justfile
install-nginx-ingress:
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install nginx-ingress ingress-nginx/ingress-nginx \
        --create-namespace \
        --namespace ingress-basic

# Resource Management
get-pods:
    kubectl get pods -A

get-services:
    kubectl get services -A

get-deployments:
    kubectl get deployments -A

# Infrastructure Management
tf-init:
    cd terraform && terraform init

tf-plan:
    cd terraform && terraform plan

tf-apply:
    cd terraform && terraform apply -auto-approve

tf-destroy:
    cd terraform && terraform destroy -auto-approve

# Complete deployment pipeline
deploy: login aks-credentials docker-build docker-push k8s-deploy

# Cleanup
cleanup:
    kubectl delete -f k8s/
    az group delete --name {{rg}} --yes --no-wait