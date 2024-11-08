output "storage_account_id" {
  description = "The ID of the created storage account for Terraform state"
  value       = module.tf-state-storage.id
}

output "storage_account_name" {
  description = "The NAME of the created storage account for Terraform state"
  value       = module.tf-state-storage.name
}

output "storage_container_name" {
  value = module.tf-state-storage.container-name
}

output "storage_container_id" {
  value = module.tf-state-storage.container-id
}

# output "user_assigned_identity_id" {
#   description = "The ID of the user-assigned managed identity for GitHub Actions"
#   value       = module.gh_usi.user_assinged_identity_id
# }

# output "user_assigned_identity_principal_id" {
#   description = "The principal ID of the user-assigned managed identity"
#   value       = module.gh_usi.user_assinged_identity_principal_id
# }

output "resource_group_name" {
  description = "The name of the resource group containing Terraform state storage"
  value       = module.tf-resource-group.name
}

output "identity_resource_group_name" {
  description = "The name of the resource group containing the managed identity"
  value       = module.identity-resource-group.name
}

output "federated_credential_name" {
  value = module.gh_federated_credential.name
}

output "federated_credential_id" {
  value = module.gh_federated_credential.id
}

output "pr_federated_credential_name" {
  value = module.gh_federated_credential-pr.pr-name
}

output "pr_federated_credential_id" {
  value = module.gh_federated_credential-pr.pr-id
}

# outputs.tf in root module
output "user_assigned_identity_id" {
  value = module.gh_usi.id
}

output "user_assigned_identity_client_id" {
  value = module.gh_usi.client_id
}

output "user_assigned_identity_principal_id" {
  value = module.gh_usi.principal_id
}

output "user_assigned_identity_name" {
  value = module.gh_usi.name
}

output "user_assigned_identity_tenant_id" {
  value = module.gh_usi.tenant_id
}

output "role_assignment_id" {
  value = module.tfstate_role_assignment.id
}

output "role_assignment_name" {
  value = module.tfstate_role_assignment.name
}

output "role_assignment_principal_id" {
  value = module.tfstate_role_assignment.principal_id
}

output "role_assignment_role_definition_name" {
  value = module.tfstate_role_assignment.role_definition_name
}

output "role_assignment_scope" {
  value = module.tfstate_role_assignment.scope
}