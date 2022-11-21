#----------------------------------- Net connection---------------------

#Localizacion 
variable "location" {

}

# Grupo de recurso 

variable "name_resource_group"{

}

# Nombre red virtual
variable "vnet_name" {
  default = "firs_vnet"
}

# Direccion red virtual
variable "address_space" {
  default = ["10.0.0.0/16"]
}

# Nombre subnet1
variable "subnet1_name" {
  default = "subnet1"
}

# Dirección subnet 1
variable "subnet1_address" {
  default = "10.0.1.0/24"
}


# Nombre del nsg
variable "NSG_name" {
  default     = "NSG1"
}

# Nombre de la ip pública
variable "publicip_name" {
}

