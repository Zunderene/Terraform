#----------------------------------- Net connection---------------------

#Localizacion 
variable "location" {}

# Grupo de recurso 
variable "name_resource_group"{}

# IpPublica
variable "public_ip_id" {

}

# Nombre red virtual
variable "vnet_name" {
  default = "vnet"
}

# Direccion red virtual
variable "address_space" {
  default = ["10.0.0.0/16"]
}

# Nombre subnet1
variable "subred" {
  default = "subnet"
}

# Dirección subnet 1
variable "subnet_address" {
  default = ["10.0.1.0/24"]
}


