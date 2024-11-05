# Get the AKS cluster resource ID
AKS_ID=$(az aks show --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME> --query id -o tsv)

# Get the ACR resource ID
ACR_ID=$(az acr show --name <ACR_NAME> --resource-group <ACR_RESOURCE_GROUP> --query id -o tsv)

# Create role assignment
az role assignment create --assignee $AKS_ID --role acrpull --scope $ACR_ID