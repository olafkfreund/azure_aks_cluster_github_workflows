terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

resource "test_assertions" "resource_group" {
  component = "resource_group"

  equal "name" {
    description = "Resource group name matches expected"
    got         = module.tf-resource-group.name
    want        = var.tf_state_rg_name
  }

  equal "location" {
    description = "Location matches expected"
    got         = module.tf-resource-group.location
    want        = var.location
  }
}

resource "test_assertions" "storage" {
  component = "storage"

  equal "account_tier" {
    description = "Storage account tier matches expected"
    got         = module.tf-state-storage.account_tier
    want        = var.account_tier
  }

  equal "replication" {
    description = "Replication type matches expected"
    got         = module.tf-state-storage.account_replication_type
    want        = var.account_replication_type
  }
}

resource "test_assertions" "identity" {
  component = "identity"

  equal "identity_name" {
    description = "User assigned identity name matches expected"
    got         = module.gh_usi.name
    want        = "${var.gh_uai_name}-${var.environment}"
  }
}

resource "test_assertions" "federated_credentials" {
  component = "federated_credentials"

  equal "subject" {
    description = "Federated credential subject matches expected"
    got         = module.gh_federated_credential.subject
    want        = "repo:${var.github_organization_target}/${var.github_repository}:environment:${var.environment}"
  }
}