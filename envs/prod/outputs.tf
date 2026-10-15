output "key_vault_name" {
  value = azurerm_key_vault.main.name
}

output "container_registry" {
  value = azurerm_container_registry.main.login_server
}
