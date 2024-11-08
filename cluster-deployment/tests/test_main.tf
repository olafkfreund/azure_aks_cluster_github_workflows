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
resource "test_assertions" "acr" {
  component = "acr"

  equal "name" {
    description = "ACR name matches expected"
    got         = module.acr.name
    want        = var.acr_name
  }

  equal "sku" {
    description = "ACR SKU matches expected"
    got         = module.acr.sku
    want        = var.sku
  }

  equal "admin_enabled" {
    description = "ACR admin enabled status matches expected"
    got         = module.acr.admin_enabled
    want        = var.admin_enabled
  }
}

resource "test_assertions" "aks" {
  component = "aks"

  equal "name" {
    description = "AKS cluster name matches expected"
    got         = module.aks.name
    want        = var.aks_name
  }

  equal "node_count" {
    description = "AKS node count matches expected"
    got         = module.aks.node_count
    want        = var.node_count
  }

  equal "vm_size" {
    description = "AKS VM size matches expected"
    got         = module.aks.vm_size
    want        = var.vm_size
  }

  check "autoscaling_limits" {
    description = "AKS autoscaling limits are correctly set"
    condition   = module.aks.min_count == var.min_count && module.aks.max_count == var.max_count
  }
}

resource "test_assertions" "azure_monitor" {
  component = "azure_monitor"

  equal "workspace_name" {
    description = "Azure Monitor workspace name matches expected"
    got         = module.azure-monitor-workspace.name
    want        = var.azure_monitor_workspace_name
  }

  equal "location" {
    description = "Azure Monitor workspace location matches resource group"
    got         = module.azure-monitor-workspace.location
    want        = module.resource-group.location
  }
}

resource "test_assertions" "managed_grafana" {
  component = "managed_grafana"

  equal "name" {
    description = "Managed Grafana name matches expected"
    got         = module.managed-grafana.name
    want        = var.grafana_name
  }

  equal "location" {
    description = "Managed Grafana location matches resource group"
    got         = module.managed-grafana.location
    want        = module.resource-group.location
  }
}