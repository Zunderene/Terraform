resource "azurerm_storage_account" "Storage_account" {
    name                        = "${var.Storage_name1}"
    resource_group_name         = "${azurerm_resource_group.rg.name}"
    location                    = "${var.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"
}