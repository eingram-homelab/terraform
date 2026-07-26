resource "azurerm_key_vault_key" "key" {
  for_each = var.keys

  name            = each.key
  key_vault_id    = var.key_vault_id
  key_type        = each.value.key_type
  key_size        = each.value.key_size
  curve           = each.value.curve
  key_opts        = each.value.key_opts
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date
  tags            = each.value.tags

  dynamic "rotation_policy" {
    for_each = each.value.rotation_policy == null ? [] : [each.value.rotation_policy]
    content {
      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry

      dynamic "automatic" {
        for_each = rotation_policy.value.time_after_creation == null && rotation_policy.value.time_before_expiry == null ? [] : [1]
        content {
          time_after_creation = rotation_policy.value.time_after_creation
          time_before_expiry  = rotation_policy.value.time_before_expiry
        }
      }
    }
  }
}
