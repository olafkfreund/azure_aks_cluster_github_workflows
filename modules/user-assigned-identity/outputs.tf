output "user_assinged_identity_id" {
  value = azurerm_user_assigned_identity.msi.id
  description = "ID of the user-assigned managed identity."
}

output "user_assinged_identity_principal_id" {
  value = azurerm_user_assigned_identity.msi.principal_id
  description = "Principal ID of the user-assigned managed identity"
}

output "id" {
  value = azurerm_user_assigned_identity.msi.id
}

output "client_id" {
  value = azurerm_user_assigned_identity.msi.client_id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.msi.principal_id
}

output "name" {
  value = azurerm_user_assigned_identity.msi.name
}

output "tenant_id" {
  value = azurerm_user_assigned_identity.msi.tenant_id
}