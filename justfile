# Variables
set dotenv-load
registry := "devacrfcaks.azurecr.io"
aks_name := "dev-fcaks"
rg := "rg-fc-aks"
resource_group_name := "rg-fcaks-tfstate"
storage_account_name := "fcdevfstate"
container_name := "tfstate"



login:
    az login
    az account set --subscription $SUBSCRIPTION_ID

aks-credentials:
    az aks get-credentials --resource-group {{rg}} --name {{aks_name}}


docker-build:
    docker build -t {{registry}}/springboot:latest ./apps/springboot-org
    docker build -t {{registry}}/springboot-mysql:latest ./apps/springboot-mysql
    docker build -t {{registry}}/aspnet-core-dotnet-core:latest ./apps/dotnet/aspnet-core-dotnet-core

docker-push:
    az acr login --name {{registry}}
    docker push {{registry}}/springboot:latest
    docker push {{registry}}/springboot-mysql:latest


k8s-deploy-springboot:
    kubectl apply -f ./apps/springboot-org/deployment.yml

k8s-deploy-springboot-mysql:
    kubectl apply -f ./apps/springboot-mysql/deployment.yml

k8s-deploy-dotnet:
    kubectl apply -f ./apps/dotnet/aspnet-core-dotnet-core/dotnet-deployment.yml


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

get-ingress:
    kubectl get ingress -A

gh-tf-init:
    cd ./github-deployment/ && terraform init

gh-tf-plan:
    cd ./github-deployment/ && terraform plan -var-file=tfvars/terraform.tfvars -out=tfplan

gh-tf-apply:
    cd ./github-deployment/ && terraform apply -auto-approve

gh-tf-test:
    cd ./github-deployment/ && terraform test -verbose

gh-tf-destroy:
    cd ./github-deployment/ && terraform destroy -auto-approve

#Azure infra  Deployment
cs-tf-init:
    cd ./cluster-deployment/ && terraform init -backend-config={{resource_group_name}} -backend-config={{storage_account_name}} -backend-config={{container_name}}

cs-tf-plan:
    cd ./cluster-deployment/ && terraform plan -var-file=tfvars/terraform.tfvars -out=tfplan

cs-tf-apply:
    cd ./cluster-deployment/ && terraform apply -auto-approve

cs-tf-test:
    cd ./cluster-deployment/ && terraform test -verbose

cs-tf-destroy:
    cd ./cluster-deployment/ && terraform destroy -auto-approve


deploy: login aks-credentials docker-build docker-push \
    k8s-deploy-springboot k8s-deploy-springboot-mysql \
    k8s-deploy-dotnet install-nginx-ingress


cleanup:
    az group delete --name {{rg}} --yes --no-wait