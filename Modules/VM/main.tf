resource "azurerm_virtual_machine" "Vm" {
    name                  = "${var.vm_name}"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
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
        sku       = "20.04.0-LTS"
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