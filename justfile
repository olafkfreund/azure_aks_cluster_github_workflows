# justfile

# Variables
set dotenv-load
registry := "devacrfcaks.azurecr.io"
aks_name := "dev-fcaks"
rg := "rg-fc-aks"


login:
    az login
    az account set --subscription $SUBSCRIPTION_ID

aks-credentials:
    az aks get-credentials --resource-group {{rg}} --name {{aks_name}}


docker-build:
    docker build -t {{registry}}/backend:latest ./apps/springboot/backend
    docker build -t {{registry}}/frontend:latest ./apps/springboot/frontend

docker-push:
    az acr login --name {{registry}}
    docker push {{registry}}/backend:latest
    docker push {{registry}}/frontend:latest


k8s-deploy:
    kubectl apply -f ./apps/springboot/backend/backend-deployment.yaml
    kubectl apply -f ./apps/springboot/frontend/frontend-deployment.yaml
    kubectl apply -f ./apps/dotnet/aspnet-core-dotnet-core/dotnet-deployment.yaml
    kubectl apply -f ./apps/dotnet/aspnet-core-dotnet-core/ingress.yaml


install-nginx-ingress:
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install nginx-ingress ingress-nginx/ingress-nginx \
        --create-namespace \
        --namespace ingress-basic

get-pods:
    kubectl get pods -A

get-services:
    kubectl get services -A

get-deployments:
    kubectl get deployments -A

#GitHub Deployment
gh-tf-init:
    cd ./github-deployment/ && terraform init

gh-tf-plan:
    cd ./github-deployment/ && terraform plan

gh-tf-apply:
    cd ./github-deployment/ && terraform apply -auto-approve

gh-tf-test:
    cd ./github-deployment/ && terraform test -verbose

gh-tf-destroy:
    cd ./github-deployment/ && terraform destroy -auto-approve

#Azure infra  Deployment
cs-tf-init:
    cd ./cluster-deployment/ && terraform init

cs-tf-plan:
    cd ./cluster-deployment/ && terraform plan

cs-tf-apply:
    cd ./cluster-deployment/ && terraform apply -auto-approve

cs-tf-test:
    cd ./cluster-deployment/ && terraform test -verbose

cs-tf-destroy:
    cd ./cluster-deployment/ && terraform destroy -auto-approve


deploy: login aks-credentials docker-build docker-push k8s-deploy


cleanup:
    kubectl delete -f k8s/
    az group delete --name {{rg}} --yes --no-wait