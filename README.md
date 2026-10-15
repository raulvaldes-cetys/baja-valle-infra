# Baja Valle Infra

Terraform for the Baja Valle Azure infrastructure: API, database, secrets, container registry, monitoring and budget.

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install) ≥ 1.9
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli), signed in with `az login`
- [gitleaks](https://github.com/gitleaks/gitleaks#installing), then enable the hooks once: `git config core.hooksPath .githooks`

## Layout

| Path | What it is |
|---|---|
| `bootstrap/` | Resource group and storage account for the remote state. Applied once with local state. |
| `envs/prod/` | The production environment. Its state lives in the remote backend. |

## Usage

The subscription id goes in a `terraform.tfvars` next to each configuration (copy `terraform.tfvars.example`; real `tfvars` files are git-ignored).

```bash
# Only the first time, or after changing the state storage
cd bootstrap && terraform init && terraform apply

cd envs/prod
terraform init
terraform plan
terraform apply
```

The remote state uses Entra ID authentication (`use_azuread_auth`). The storage account has shared keys disabled, so your account needs the *Storage Blob Data Contributor* role on it (granted to whoever applies `bootstrap/`).

`bootstrap/terraform.tfstate` only holds the names of the state resources; if it is lost, the resources can be imported again.

## Secrets

Application secrets live in Key Vault and are never managed by Terraform, so they don't end up in the state. The API reads them with its managed identity (`id-bajavalle-api`, role *Key Vault Secrets User*). Whoever applies `envs/prod` gets *Key Vault Secrets Officer* to load them:

```bash
KV=$(terraform -chdir=envs/prod output -raw key_vault_name)
az keyvault secret set --vault-name "$KV" --name <secret-name> --file <file-with-the-value>
```

| Secret | API variable | Value |
|---|---|---|
| `database-url` | `DATABASE_URL` | Runtime role `baja_valle_app` |
| `migrator-database-url` | `DIRECT_URL` | Database admin, only for migrations |
| `encryption-keys` | `ENCRYPTION_KEYS` | `pnpm crypto:keys` in baja-valle-service |
| `blind-index-key` | `BLIND_INDEX_KEY` | `pnpm crypto:keys` |
| `jwt-access-secret` | `JWT_ACCESS_SECRET` | `pnpm crypto:keys` |
| `mail-host`, `mail-port`, `mail-secure`, `mail-user`, `mail-pass`, `mail-to` | `MAIL_*` | SMTP account |

Use `--file` (or `--value` from a variable) so values never appear in the shell history.

## Cost controls

- Budget of `monthly_budget_usd` (default $5) on the resource group with email alerts at 50%, 80% and 100%.
- Log Analytics daily cap of 0.05 GB and 30-day retention.
