# GitHub Actions Workflow Documentation - Infrastructure Deployment

## Overview

This workflow handles Terraform infrastructure deployment with plan and apply stages.

## Workflow Structure

### Plan Stage Steps

1. **Format Terraform Plan Output**

   ```yaml
   - name: Convert Plan to String
     id: tf-plan-string
     run: |
       # Formats terraform plan with collapsible markdown output
       # Includes random delimiter for output parsing
   ```

2. **Publish Plan Summary**

   ```yaml
   - name: Publish Terraform Plan to Task Summary
     # Adds plan to GitHub step summary
   ```

3. **PR Comments**

   ```yaml
   - name: Push Terraform Output to PR
     # Posts plan as comment on PR
     # Only runs on non-main branches
   ```

### Apply Stage Steps

1. **Azure Authentication**

   ```yaml
   - name: Azure login
     # Authenticates using Azure service principal
     # Required secrets:
       - AZURE_CLIENT_ID
       - AZURE_TENANT_ID
       - AZURE_SUBSCRIPTION_ID
   ```

2. **Terraform Setup**

   ```yaml
   - name: Setup Terraform
     # Installs Terraform CLI
   ```

3. **Backend Configuration**

   ```yaml
   - name: Terraform Init
     # Initializes backend with Azure storage
     # Required secrets:
       - BACKEND_AZURE_RESOURCE_GROUP_NAME
       - BACKEND_AZURE_STORAGE_ACCOUNT_NAME
       - BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME
   ```

4. **Plan Retrieval & Apply**

   ```yaml
   - name: Download Terraform Plan
     # Downloads plan artifact
   - name: Terraform Apply
     # Applies the plan automatically
   ```

## Required Secrets

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `BACKEND_AZURE_RESOURCE_GROUP_NAME`
- `BACKEND_AZURE_STORAGE_ACCOUNT_NAME`
- `BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME`
- `GITHUB_TOKEN`

## Environment

- Runs on: `ubuntu-latest`
- Environment: `dev`
- Working directory: cluster-deployment

## Dependencies

- Plan stage must complete before Apply stage
- Requires Azure backend storage configuration
- GitHub Actions permissions for PR comments