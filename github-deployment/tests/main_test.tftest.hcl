provider "azurerm" {
  features {}
}

variables {
  tf_state_rg_name              = "rg-fcaks-tfstate"
  identity_rg_name              = "rg-fcaks-identity"
  location                      = "uksouth"
  storage_account_name          = "fcdevfstate"
  container_name                = "tfstate"
  account_replication_type      = "LRS"
  account_tier                  = "Standard"
  gh_uai_name                   = "uai-gh"
  environment                   = "dev"
  github_organization_target    = "olafkfreund"
  github_repository             = "azure_aks_cluster_github_workflows"
  owner_role_name               = "olafkfreund"
  tags = {
    Environment = "dev"
    owner       = "olafkfreund"
  }
}

run "resource_group_creation" {
  command = plan

  assert {
    condition     = module.tf-resource-group.name == var.tf_state_rg_name
    error_message = "TF state resource group name did not match expected value"
  }

  # assert {
  #   condition     = module.tf-resource-group.id != ""
  #   error_message = "Resource group ID should not be empty"
  # }

  assert {
    condition     = module.tf-resource-group.location == var.location
    error_message = "Resource group location does not match input"
  }
}

run "storage_account_creation" {
  command = plan

  assert {
    condition     = module.tf-state-storage.name == var.storage_account_name
    error_message = "Storage account name did not match expected value"
  }

  assert {
    condition     = module.tf-state-storage.container-name == var.container_name
    error_message = "Container name did not match expected value"
  }
}

run "user_assigned_identity_creation" {
  command = plan

  assert {
    condition     = module.gh_usi.name == "${var.gh_uai_name}-${var.environment}"
    error_message = "User assigned identity name did not match expected value"
  }
}

run "federated_credentials_creation" {
  command = plan

  assert {
    condition     = module.gh_federated_credential.name == "${var.github_organization_target}-${var.github_repository}-${var.environment}"
    error_message = "Federated credential name did not match expected value"
  }

  assert {
    condition     = module.gh_federated_credential-pr.name == "${var.github_organization_target}-${var.github_repository}-pr"
    error_message = "PR federated credential name did not match expected value"
  }
}

run "role_assignments" {
  command = plan

  assert {
    condition     = module.tfstate_role_assignment.role_definition_name == "Storage Blob Data Contributor"
    error_message = "Storage role assignment did not match expected value"
  }
}