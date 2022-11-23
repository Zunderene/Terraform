#############################
## aplicacion - Variables ##
#############################

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
  #default="cloud"
}







