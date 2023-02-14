## terraform-vault-secrets

A Terraform module to look up secrets in Vault and return their values.

The module expects a map of strings as input, where the values will be looked up in Vault if they are in the following format:

```vault:{mount}/data/{secret_name}#KEY```

Non-matching values will be pruned by default, or otherwise returned unchanged.

Example:

```
module "database_credentials" {
  source = "samarkand-global/secrets/vault"
  version = "0.1.0"

  vault_lookups = {
    "db_username" = "admin"
    "db_password" = "vault:mysecrets/data/db-credentials/root#PASSWORD"
  }

  prune = false
}
```

Will return the output:

```
secret_values = {
  "db_username" = "admin"
  "db_password" = "mytopsecretpassword"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 3.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_kv_secret_v2.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secret_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parse_value_regex"></a> [parse\_value\_regex](#input\_parse\_value\_regex) | Regular expression used to parse Vault lookups into a map. | `string` | `"^vault:(?P<mount>.*?)/data/(?P<name>.*?)#(?P<key>.*)$"` | no |
| <a name="input_prune"></a> [prune](#input\_prune) | Whether to prune any non-secret values from the output. If 'false' then then non-secret values will be returned unchanged. | `bool` | `true` | no |
| <a name="input_validation"></a> [validation](#input\_validation) | Whether to validate the values of var.vault\_secrets are in the format 'vault:{mount\_name}/data/{secret\_name}#{key}' and fail if any are not. Overrides var.prune. | `bool` | `false` | no |
| <a name="input_validation_regex"></a> [validation\_regex](#input\_validation\_regex) | The regular expression used to determine if the values of var.vault\_secrets should be looked up in Vault. | `string` | `"^vault:.*?/data/.*?#.*$"` | no |
| <a name="input_vault_lookups"></a> [vault\_lookups](#input\_vault\_lookups) | Map of Vault secrets to be retrieved. Values must be in the format 'vault:{mount\_name}/data/{secret\_name}#{key}'. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_values"></a> [secret\_values](#output\_secret\_values) | n/a |
