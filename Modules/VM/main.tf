data "azurerm_subnet" "sub01id" {
  name                 = var.subred
  virtual_network_name = var.vnet_name
  resource_group_name  = var.name_resource_group
}
resource "azurerm_virtual_machine" "Vm" {
    name                  = "${var.vm_name}"
    location              = "${var.location}"
    resource_group_name   = var.name_resource_group
    network_interface_ids = ["${azurerm_network_interface.NIC.id}"]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "OsAzure"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.vm_name}"
        admin_username = "${var.user_name}"
        admin_password = "${var.user_password}"
    }

    storage_data_disk {
        name                = "vm-Data-Disk"
        disk_size_gb        = "100"
        managed_disk_type   = "Standard_LRS"
        create_option       = "Empty"
        lun                 = 0
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    /*boot_diagnostics {
        enabled = "false"
    }*/

}

# Creación del Network Security Group y sus normas
resource "azurerm_network_security_group" "NSG" {
    name                = var.NSG_name
    location            = var.location
    resource_group_name = var.name_resource_group
    
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
    name                      = var.NIC_name1
    location                  = var.location
    resource_group_name       = var.name_resource_group
    #network_security_group_id = azurerm_network_security_group.NSG.name

    ip_configuration {
        name                          = var.NIC_name_config
        subnet_id                     = data.azurerm_subnet.sub01id.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = var.public_ip_id
    }

}

resource "azurerm_network_interface_security_group_association" "NSG" {
  network_interface_id      = azurerm_network_interface.NIC.id
  network_security_group_id = azurerm_network_security_group.NSG.id
}

