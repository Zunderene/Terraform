provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "MyKeyVault" {
  name                        = var.key_vault
  location                    = "${var.location}"
  resource_group_name         = "${var.name_resource_group}"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.my_sku_name

}