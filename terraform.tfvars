####################
# Common Variables #
####################
__location__     = "westeurope"
__gruporesource__ = "cloud"
__network-vnet-cidr__ = "10.128.0.0/16"
__network-subnet-cidr__ = "10.128.1.0/24"

__maquinas__ = {
    "VM01" = {
    size = "Standard_DS1_v2"
    source_image_offer = "UbuntuServer"
    source_image_publisher = "Canonical"
    storage_account_type = "Standard_LRS"
    admin_username = "azureuser"
    if_public_ip = false
    securities_rule_vm = {
        "rule-ssh" = {
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      =  "*"
            destination_address_prefix =  "*"
        },
        "rule-sql" = {
            priority                   = 101
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "5432"
            source_address_prefix      =  "*"
            destination_address_prefix =  "*"
        }
    }
    
  },
  "VM02" = {
    size = "Standard_DS1_v2"
    source_image_offer = "UbuntuServer"
    source_image_publisher = "Canonical"
    storage_account_type = "Standard_LRS"
    admin_username = "azureuser"
    if_public_ip = true
     securities_rule_vm = {
        "rule-vm-dr" = {
            priority                   = 101
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      =  "*"
            destination_address_prefix =  "*"
        }
    }
    
  }
}
