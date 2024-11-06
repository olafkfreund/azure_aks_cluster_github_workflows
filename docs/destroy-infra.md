# Infrastructure Destruction Workflow Documentation

## Overview

This GitHub Actions workflow automates the destruction of Azure Kubernetes Service (AKS) infrastructure using Terraform.

## Workflow Triggers

- Manual trigger via `workflow_dispatch`
- (Commented out) Pull request trigger for main branch

## Permissions

```yaml
permissions:
  contents: read
  id-token: write
  pull-requests: write
```

## Environment Variables

```yaml
env:
  ARM_CLIENT_ID: Azure service principal client ID
  ARM_SUBSCRIPTION_ID: Azure subscription ID  
  ARM_TENANT_ID: Azure tenant ID
```

## Required Secrets

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID` 
- `AZURE_SUBSCRIPTION_ID`
- `BACKEND_AZURE_RESOURCE_GROUP_NAME`
- `BACKEND_AZURE_STORAGE_ACCOUNT_NAME`
- `BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME`

## Workflow Steps

### 1. Azure Authentication

```yaml
- name: Azure login
  uses: azure/login@v2
```

Authenticates with Azure using service principal credentials.

### 2. Terraform Setup

```yaml
- name: Setup Terraform
  uses: hashicorp/setup-terraform@v2
```

Installs Terraform CLI for infrastructure management.

### 3. Terraform Backend Configuration

```yaml
- name: Terraform Init
  run: terraform init [backend-config...]
```

Initializes Terraform with Azure storage backend configuration.

### 4. Execute Destroy

```yaml
- name: Terraform Apply
  run: terraform destroy -auto-approve
```

Executes Terraform destroy command to remove all infrastructure.

## Environment

- Runs on: `ubuntu-latest`
- Environment: `destroy`
- Working directory: cluster-deployment

## Notes

- Uses Azure remote state storage
- Auto-approves destruction without confirmation
- Requires Azure authentication
- Designed for complete infrastructure teardown