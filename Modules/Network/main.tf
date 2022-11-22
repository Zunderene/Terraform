

## Creando red virtual
resource "azurerm_virtual_network" "Vnet" {
  name                  = var.vnet_name
  address_space         = var.address_space
  location              = var.location
  resource_group_name   = var.name_resource_group
}



# Creando subnet
resource "azurerm_subnet" "subnet" {
    name                 = var.subred
    resource_group_name  = var.name_resource_group
    virtual_network_name = azurerm_virtual_network.Vnet.name
    address_prefixes     = var.subnet_address
    
}

