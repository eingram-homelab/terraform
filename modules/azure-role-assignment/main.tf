resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.scope != null ? var.scope : "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}
