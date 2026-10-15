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
