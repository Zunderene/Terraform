# Generate a random vm name
resource "random_string" "vm-name" {
  length  = 8
  upper   = false
  numeric = false
  lower   = true
  special = false
}


resource "azurerm_storage_account" "Storage_account" {
  name                     = "storage${random_string.vm-name.result}backup"
  resource_group_name      = var.name_resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.name_storage
  storage_account_name  = azurerm_storage_account.Storage_account.name
  container_access_type = var.access_type
}

