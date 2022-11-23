# Creando el grupo de recursos.

resource "azurerm_resource_group" "RG" {
  name     = "${lower(replace(var.proyecto," ","-"))}-${var.entorno}-rg"
  location = var.location
  tags = {
    application = var.proyecto
    enviroment  = var.entorno
  }
}


# Creando red virtual
resource "azurerm_virtual_network" "Vnet" {
  name                  = "${lower(replace(var.proyecto," ","-"))}-${var.entorno}-vnet"
  address_space         = [var.network-vnet-cidr]
  location              = azurerm_resource_group.RG.location
  resource_group_name   = azurerm_resource_group.RG.name

  tags = {
    application = var.proyecto
    environment = var.entorno
  }

  
}

# Creando subnet
resource "azurerm_subnet" "subnet" {
    name                 = "${lower(replace(var.proyecto," ","-"))}-${var.entorno}-subnet"
    resource_group_name  = azurerm_resource_group.RG.name
    virtual_network_name = azurerm_virtual_network.Vnet.name
    address_prefixes     = [var.network-subnet-cidr]
    
}

