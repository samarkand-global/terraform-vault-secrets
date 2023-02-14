output "secret_values" {
  value     = var.prune ? local.vault_secrets : local.merged_lookups
  sensitive = true
}
