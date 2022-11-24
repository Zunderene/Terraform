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
locals {
  nsg_settings = [
    { name = "sql-${lower(var.entorno)}-${random_string.vm-name.result}-nsg-01" },
    { name = "sql-${lower(var.entorno)}-${random_string.vm-name.result}-nsg-02"},
  ]
}

resource "azurerm_network_security_group" "vm-nsg" {
    depends_on = [ var.network_resource_group]
    count     = 2
    name                    = local.nsg_settings[count.index].name
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
        source_address_prefix      = local.nsg_settings[count.index] == 0 ? "Internet" : "VirtualNetwork"
        destination_address_prefix = local.nsg_settings[count.index] == 0 ? "Internet" : "VirtualNetwork"
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
        source_address_prefix      = local.nsg_settings[count.index] == 0 ? "*" : "VirtualNetwork"
        destination_address_prefix = local.nsg_settings[count.index] == 0 ? "*" : "VirtualNetwork"
  }
  tags = {
    environment = var.entorno
  }

}

resource "az" "name" {
  
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
  count = 2
  name                = "vm-${random_string.vm-name.result}-nic-${count.index}"
  location            = var.network_resource_group.location
  resource_group_name = var.network_resource_group.name
  
  ip_configuration {
    name                          = "Internet"
    subnet_id                     = var.network_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = count.index == 0 ? azurerm_public_ip.vm_ip.id : null
  }

  tags = { 
    environment = var.entorno
  }
}
resource "tls_private_key" "ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {

    depends_on=[azurerm_network_interface.vm-private-nic]

    name                = "vm-${lower(var.entorno)}-${random_string.vm-name.result}-vm"
    location            = var.network_resource_group.location
    resource_group_name = var.network_resource_group.name
  
    network_interface_ids =  [azurerm_network_interface.vm-private-nic-[count.index].id] 
    size               = "Standard_DS1_v2"

    #delete_os_disk_on_termination    = var.sql_delete_os_disk_on_termination
    #delete_data_disks_on_termination = var.sql_delete_data_disks_on_termination

  os_disk {
    name                    = "disk${random_string.vm-name.result}vm-${count.index}"
    caching                 = "ReadWrite"
    storage_account_type    = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

}


resource "azurerm_network_interface_security_group_association" "NSG-Public" {
  count = 2
  network_interface_id      = azurerm_network_interface.vm-private-nic[count.index].id 
  network_security_group_id = azurerm_network_security_group.vm-nsg[count.index].id
}

#resource "azurerm_network_interface_security_group_association" "NSG" {
#  network_interface_id      = azurerm_network_interface.vm-private-nic-02.id 
#  network_security_group_id = azurerm_network_security_group.vm-nsg-02.id
#}