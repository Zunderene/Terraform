resource "azurerm_container_registry" "acr" {
  name                  = "${var.ACR}"
  resource_group_name   = "${var.name_resource_group}"
  location              = "${var.location}"
  sku                 = "${var.sku_ACR}"
  admin_enabled       = "${var.admin_ACR}"
}