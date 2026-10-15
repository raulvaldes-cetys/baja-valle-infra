# Baja Valle Infra

Terraform for the Baja Valle Azure infrastructure: API, database, secrets, container registry, monitoring and budget.

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install) ≥ 1.9
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli), signed in with `az login`
- [gitleaks](https://github.com/gitleaks/gitleaks#installing), then enable the hooks once: `git config core.hooksPath .githooks`
