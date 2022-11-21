# Creando red virtual
resource "azurerm_virtual_network" "Vnet" {
  name = "${var.vnet_name}"
  address_space = var.address_space
  location = "${var.location}"
  resource_group_name = "${var.name_resource_group}"
}

# Creando subnet1
resource "azurerm_subnet" "sub1" {
    name                 = "${var.subnet1_name}"
    resource_group_name  = "${var.name_resource_group}"
    virtual_network_name = "${azurerm_virtual_network.Vnet.name}"
    address_prefix       = "${var.subnet1_address}"
}

# Creación de IP pública
resource "azurerm_public_ip" "publicIP" {
    name                         =  var.publicip_name
    location                     = "${var.location}"
    resource_group_name          = "${var.name_resource_group}"
    allocation_method            = "Dynamic"
}

# Creación del Network Security Group y sus normas
resource "azurerm_network_security_group" "NSG" {
    name                = "${var.NSG_name}"
    location            = "${var.location}"
    resource_group_name = "${var.name_resource_group}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 2000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

# Creando interfaz de red
resource "azurerm_network_interface" "NIC" {
    name                      = "${var.NIC_name1}"
    location                  = "${var.location}"
    resource_group_name       = "${var.name_resource_group}"
    #network_security_group_id = "${azurerm_network_security_group.NSG.name}"

    ip_configuration {
        name                          = "${var.NIC_name_config}"
        subnet_id                     = "${azurerm_subnet.sub1.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.publicIP.id}"
    }

}