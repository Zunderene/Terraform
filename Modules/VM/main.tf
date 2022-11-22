data "azurerm_subnet" "sub01id" {
  name                 = var.subred
  virtual_network_name = var.VPC
  resource_group_name  = var.name_resource_group
}

data "azurerm_public_ip" "ipPublic" {
  name                = var.ipPublic
  resource_group_name = var.name_resource_group
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

    os_profile_linux_config {
        disable_password_authentication = false
    }

    /*boot_diagnostics {
        enabled = "false"
    }*/

}

# Creando interfaz de red
resource "azurerm_network_interface" "NIC" {
    name                      = "${var.NIC_name1}"
    location                  = "${var.location}"
    resource_group_name       = "${var.name_resource_group}"
    #network_security_group_id = "${azurerm_network_security_group.NSG.name}"

    ip_configuration {
        name                          = "${var.NIC_name_config}"
        subnet_id                     = "${data.azurerm_subnet.sub01id.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${data.azurerm_public_ip.ipPublic.id}"
    }

}