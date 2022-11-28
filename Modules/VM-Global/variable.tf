# Azure virtual machine storage settings #

variable "network_resource_group_name" {
  description = "Nombre del grupo de recursos"
  type  = string
}

variable "network_subnet" {
  description = "Nombre de la subnet a la que pertenece"
  type  = string
}

variable "ip_private_addres" {
  description = "ip private de la VM"
  type = string
  default = "Dynamic"
}

variable "location" {
  description = "Azure region"
  type = string
}

variable "name" {
  description = "Nombre de la Maquina virtual"
  type = string
}

variable "size" {
  description = "Tamaño de la instancia"
  type = string
}

variable "storage_account_type" {
  type = string
  default = "Standard_LRS"
}

variable "source_image_publisher" {
  description = "Distribuidora de la imagen"
  type = string
  default = "Canonical"
}

variable "source_image_offer" {
  description = "Tipo de imagen"
  type = string
  default = "UbuntuServer"
}

variable "source_image_sku" {
  description = "Version del SO"
  type = string
  default = "18.04-LTS"
}

variable "source_image_version" {
  description = "Versión de la imagen"
  type = string
  default = "latest"
}

# Azure virtual machine OS profile #

variable "admin_username" {
  description = "Usuario de la cuenta de administrador de la VM"
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "Contraseña de la cuenta de administrador de la VM"
  type        = string
  default     = ""
}

variable "if_public_ip" {
  description = "Determina si la VM tiene asignada una ip publica"
  type = bool
  default = false
}

variable "securities_rule_vm" {
  description = "Define las reglas de seguridad para la VM"
  #type = list(object())
  default = { 
    "rule01" = {
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5432"
        source_address_prefix      =  "*"
        destination_address_prefix =  "*"
    }
  }
}




