#####################################
## Azure VM - Main ##
#####################################

# Generate a random vm name
resource "random_string" "vm-name" {
  length  = 8
  upper   = false
  number  = false
  lower   = true
  special = false
}


#---------------------------------------------------------------
# Generates SSH2 key Pair for Linux VM's (Dev Environment only)
#---------------------------------------------------------------
#resource "tls_private_key" "rsa" {
#  count     = var.generate_admin_ssh_key ? 1 : 0
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

## Creacion del grupo de seguridad para dar acceso SSH y SQL
# Este grupo de recurso esta pensado solo accesible desde el interior de la red virtual no sale de internet
# Advite acceso puerto postgresSQL y SSH
#
resource "azurerm_network_security_group" "vm-nsg" {
    depends_on = [ var.network_resource_group]
    name                    = "sql-${lower(var.entorno)}-${random_string.vm-name.result}-nsg"
    location                = var.network_resource_group.location
    resource_group_name     = var.network_resource_group.name

    security_rule {
        name                       = "AllowSQL"
        description                = "Allow SQL"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5432"
        source_address_prefix      = "Internet"
        destination_address_prefix = "Internet"
  }

  security_rule {
        name                       = "AllowSSH"
        description                = "Allow SSH"
        priority                   = 150
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
  tags = {
    environment = var.entorno
  }

}

resource "azurerm_public_ip" "vm_ip" {
  name                = "ip-${random_string.vm-name.result}-public"
  location            = var.network_resource_group.location
  resource_group_name = var.network_resource_group.name
  allocation_method   = "Static"
}

# Create Network Card for SQL VM
resource "azurerm_network_interface" "vm-private-nic" {
  depends_on=[var.network_resource_group]

  name                = "vm-${random_string.vm-name.result}-nic"
  location            = var.network_resource_group.location
  resource_group_name = var.network_resource_group.name
  
  ip_configuration {
    name                          = "Internet"
    subnet_id                     = var.network_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  azurerm_public_ip.vm_ip.id 
  }

  tags = { 
    environment = var.entorno
  }
}


resource "azurerm_virtual_machine" "Vm" {
    depends_on=[azurerm_network_interface.vm-private-nic]

    name                = "vm-${lower(var.entorno)}-${random_string.vm-name.result}-vm"
    location            = var.network_resource_group.location
    resource_group_name = var.network_resource_group.name
  
    network_interface_ids =  [azurerm_network_interface.vm-private-nic.id] 
    vm_size               = "Standard_DS1_v2"

    delete_os_disk_on_termination    = var.sql_delete_os_disk_on_termination
    delete_data_disks_on_termination = var.sql_delete_data_disks_on_termination


    storage_os_disk {
        name              = "disk${random_string.vm-name.result}vm"
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
        computer_name  = "vm-${random_string.vm-name.result}-vm"
        admin_username = var.sql_admin_username
        admin_password = var.sql_admin_password
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    /*boot_diagnostics {
        enabled = "false"
    }*/

}

resource "azurerm_network_interface_security_group_association" "NSG-Public" {
  network_interface_id      = azurerm_network_interface.vm-private-nic.id 
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}
