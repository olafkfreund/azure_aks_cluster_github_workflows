# GitHub Infrastructure Terraform Test Workflow Documentation

## Overview

This GitHub Actions workflow runs automated tests on the Terraform configuration for GitHub infrastructure deployment.

## Workflow Triggers

- Manual trigger via `workflow_dispatch`
- (Commented out) Automatic triggers for:
  - Pull requests to main branch
  - Pushes to main branch

## Environment Requirements

### Required Secrets

- `AZURE_CLIENT_ID`: Azure service principal client ID
- `AZURE_TENANT_ID`: Azure tenant ID
- `AZURE_SUBSCRIPTION_ID`: Azure subscription ID

## Workflow Steps

### 1. Environment Setup

```yaml
- uses: actions/checkout@v3
- uses: hashicorp/setup-terraform@v2
  with:
    terraform_version: '1.5.0'
```

- Checks out repository code
- Installs Terraform v1.5.0

### 2. Azure Authentication

```yaml
- uses: azure/login@v2
```

- Authenticates with Azure using OIDC
- Requires Azure service principal credentials

### 3. Terraform Testing

```yaml
- name: Terraform Init GitHub
  run: terraform init

- name: Run Terraform Tests GitHub
  run: terraform test -verbose
```

- Initializes Terraform in the `github-deployment` directory
- Runs Terraform tests with verbose output

### 4. Test Reporting

```yaml
- uses: dorny/test-reporter@v1
```

- Reports test results in JUnit format
- Publishes results even if tests fail (`if: always()`)
- Looks for test results in `TestResults/*.xml`

## Usage

1. Ensure Azure credentials are configured in repository secrets
2. Run workflow manually through GitHub Actions UI
3. View test results in the Actions tab

## Notes

- Uses Terraform 1.5.0 specifically
- Tests run in the `github-deployment` directory
- Results published in JUnit format for easy viewing
- Continues to publish results even if tests fail