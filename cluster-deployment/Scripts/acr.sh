#!/usr/bin/env bash

if [ -z "$RESOURCE_GROUP" ]; then
  echo "Error: RESOURCE_GROUP is not set."
  exit 1
fi

if [ -z "$AKS_CLUSTER_NAME" ]; then
  echo "Error: AKS_CLUSTER_NAME is not set."
  exit 1
fi
AKS_ID=$(az aks show --resource-group "$RESOURCE_GROUP" --name "$AKS_CLUSTER_NAME" --query id -o tsv)

if [ -z "$ACR_NAME" ]; then
  echo "Error: ACR_NAME is not set."
  exit 1
fi

ACR_ID=$(az acr show --name "$ACR_NAME" --resource-group "$ACR_RESOURCE_GROUP" --query id -o tsv)

if [ -z "$AKS_ID" ]; then
  echo "Error: Failed to retrieve AKS_ID."
  exit 1
fi

if [ -z "$ACR_ID" ]; then
  echo "Error: Failed to retrieve ACR_ID."
  exit 1
fi

az role assignment create --assignee "$AKS_ID" --role acrpull --scope "$ACR_ID"