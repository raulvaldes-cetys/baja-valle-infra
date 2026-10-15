locals {
  tags = {
    project = "baja-valle"
    env     = "shared"
    owner   = var.owner
    course  = "cloud-computing"
  }
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-bajavalle-tfstate"
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "stbvtfstate${random_string.suffix.result}"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  allow_nested_items_to_be_public = false
  default_to_oauth_authentication = true
  tags                            = local.tags

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }
}

# Shared keys are disabled, so state data access is RBAC only
resource "azurerm_role_assignment" "state_admin" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "time_sleep" "rbac_propagation" {
  depends_on      = [azurerm_role_assignment.state_admin]
  create_duration = "90s"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"

  depends_on = [time_sleep.rbac_propagation]
}
