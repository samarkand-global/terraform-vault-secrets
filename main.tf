locals {
  # Error if any values don't match the validation regex
  strict_validation = var.validation ? [
    for v in values(var.vault_lookups) :
    regex(var.validation_regex, v)
  ] : null

  # Parse values that can be validated into a map containing mount, secret name and key
  validated_vault_lookups = {
    for k, v in var.vault_lookups :
    k => regex(var.parse_value_regex, v) if can(regex(var.validation_regex, v))
  }

  # Extract the required keys from the looked-up secrets
  vault_secrets = {
    for k, v in local.validated_vault_lookups :
    k => data.vault_kv_secret_v2.this[k].data[v.key]
  }

  # Merge the secret values into the original map of lookups
  merged_lookups = merge(var.vault_lookups, local.vault_secrets)
}

data "vault_kv_secret_v2" "this" {
  for_each = local.validated_vault_lookups

  mount = each.value.mount
  name  = each.value.name
}



