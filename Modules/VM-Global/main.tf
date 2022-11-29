#####################################
## Azure VM - Main ##
#####################################


resource "azurerm_network_security_group" "vm-nsg" {

    name                    = "${var.name}-vm-nsg"
    location                = var.location
    resource_group_name     = var.network_resource_group_name
    
  tags = {
    environment = var.name
  }
}

resource "azurerm_network_security_rule" "nsr" {

  for_each = var.securities_rule_vm
  name                       = each.key
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
  
  network_security_group_name = azurerm_network_security_group.vm-nsg.name
  resource_group_name = var.network_resource_group_name



}

resource "azurerm_public_ip" "vm_ip" {
  count =  var.if_public_ip ? 1 : 0

  name                = "ip-public-${var.name}"
  location            = var.location
  resource_group_name = var.network_resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "vm-private-nic" {

  name                = "vm-${var.name}-ni"
  location            = var.location
  resource_group_name = var.network_resource_group_name
  
  ip_configuration {
    name                          = "${var.name}-ip-configure"
    subnet_id                     = var.network_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.if_public_ip  ? azurerm_public_ip.vm_ip[0].id : null
  }

}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {

    depends_on=[azurerm_network_interface.vm-private-nic]
    name                = "vm-${var.name}-vm"
    location            = var.location
    resource_group_name = var.network_resource_group_name
  
    network_interface_ids =  [azurerm_network_interface.vm-private-nic.id] 
    size                  = var.size 


  os_disk {
    name                    = "disk${var.name}vm"
    caching                 = "ReadWrite"
    storage_account_type    = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  computer_name                   = var.name
  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

}

resource "azurerm_network_interface_security_group_association" "NSG-Public" {
  network_interface_id      = azurerm_network_interface.vm-private-nic.id 
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}
