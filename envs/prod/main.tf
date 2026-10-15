locals {
  name = "bajavalle"
  tags = {
    project = "baja-valle"
    env     = "prod"
    owner   = var.owner
    course  = "cloud-computing"
  }
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name}-prod"
  location = var.location
  tags     = local.tags
}
