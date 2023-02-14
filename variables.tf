variable "vault_lookups" {
  description = "Map of Vault secrets to be retrieved. Values must be in the format 'vault:{mount_name}/data/{secret_name}#{key}'."
  type        = map(string)
}

variable "prune" {
  description = "Whether to prune any non-secret values from the output. If 'false' then then non-secret values will be returned unchanged."
  default     = true
}

variable "validation" {
  description = "Whether to validate the values of var.vault_secrets are in the format 'vault:{mount_name}/data/{secret_name}#{key}' and fail if any are not. Overrides var.prune."
  default     = false
}

variable "validation_regex" {
  description = "The regular expression used to determine if the values of var.vault_secrets should be looked up in Vault."
  type        = string
  default     = "^vault:.*?/data/.*?#.*$"
}

variable "parse_value_regex" {
  description = "Regular expression used to parse Vault lookups into a map."
  type        = string
  default     = "^vault:(?P<mount>.*?)/data/(?P<name>.*?)#(?P<key>.*)$"
}

