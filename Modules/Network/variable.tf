
##############################
## Net connection - Variables ##
##############################

variable "resource_group" {
  description = "Grupo de recursos"
  type = string
}


variable "location" {
  type = string
  description = "Localizacion"
}


variable "network-vnet-cidr" {
  type        = list
  description = "CIDR de la red virtual (VNET)"
}

variable "network-subnet-cidr" {
  type        = list
  description = "CIDR de la subnet"
}
