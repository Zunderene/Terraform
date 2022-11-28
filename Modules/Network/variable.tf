
##############################
## Net connection - Variables ##
##############################

variable "network-vnet-cidr" {
  type        = string
  description = "CIDR de la red virtual (VNET)"
}

variable "network-subnet-cidr" {
  type        = string
  description = "CIDR de la subnet"
}
# Nombre del proyecto.
variable "proyecto" {
  type        = string
  description = "Nombre de todos los recursos"
}

# Localizacion
variable "location" {
  type        = string
  description = "Region donde va ha ser creado el grupo ded recursos"
  default     = "west europe"
}

# Entorno
variable "entorno" {
  type        = string
  description = "Módulo que ha sido procesado"
}
