# Fichero de variables. 

# Nombre del grupo de recursos.
variable "name_resource_group" {
  default = "Proyecto_Cloud"
}
# Localización
variable "location" {
  default = [ "North Europe", "West Europe"]
}

# Nombre subnet1
variable "subnet" {
  default = "subnet"
}
# Nombre red virtual
variable "vnet_name" {
  default = "firs_vnet"
}
# Nombre de la ip pública
variable "publicip_name" {
  default = "Public-Ip"
}











