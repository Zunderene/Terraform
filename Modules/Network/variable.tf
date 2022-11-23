
##############################
## Net connection - Variables ##
##############################

variable "network-vnet-cidr" {
  type        = string
  description = "El CIDR de la red virtual (VNET)"
}

variable "network-subnet-cidr" {
  type        = string
  description = "El CIDR de la subnet"
}
# Nombre del proyecto.
variable "proyecto" {
  type = string
  description = "Este nombre se usa para nombrar todos los recursos"
}

# Localizacion
variable "location" {
  type = string
  description = "Esta variable almacena la region donde va ha ser creado el grupo ded recursos"
  default = "west europe"
}

# Entorno
variable "entorno"{
  type = string
  description = "Esta variable indica de que modulo fue procesado"
}
