
# Creación de la red virtual
resource "azurerm_virtual_network" "Vnet" {
  name                = "vnet"
  address_space       = var.network-vnet-cidr
  location            = var.location
  resource_group_name = var.resource_group

}

# Creación de la subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.resource_group}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = var.network-subnet-cidr

}



