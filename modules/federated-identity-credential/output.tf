# outputs.tf in gh_federated_credential module
output "name" {
  value = azurerm_federated_identity_credential.cred.name
}

output "id" {
  value = azurerm_federated_identity_credential.cred.id
}

output "pr-name" {
  value = azurerm_federated_identity_credential.cred.name
}

output "pr-id" {
  value = azurerm_federated_identity_credential.cred.id
}