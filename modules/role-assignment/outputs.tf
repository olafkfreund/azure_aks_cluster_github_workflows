output "id" {
  value = azurerm_role_assignment.role.id
  description = "The Id of the Role Assignment"
}
output "name" {
  value = azurerm_role_assignment.role.name
}

output "principal_id" {
  value = azurerm_role_assignment.role.principal_id
}

output "role_definition_name" {
  value = azurerm_role_assignment.role.role_definition_name
}

output "scope" {
  value = azurerm_role_assignment.role.scope
}