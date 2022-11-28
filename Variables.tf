variable "proyecto" {
  type        = string
  description = "Nombre a usar para todos los recursos."
}

variable "location" {
  type        = string
  description = "Region donde va ha ser creado el grupo ded recursos."
  default     = "west europe"
}

variable "entorno" {
  type        = string
  description = "Modulo que ha sido procesado"
  default     = "jira"
}

variable "subnet_cidr" {
  type        = string
  description = "Rango de ip para la subnet cidr"
  default     = "10.128.1.0/24"
}

variable "vnet_cidr" {
  type        = string
  description = "Ranbo de ip para la vnet cidr"
  default     = "10.128.0.0/16"
}

variable "admin_pass" {
  type        = string
  description = "Contraseña del administrador para el módulo de las máquinas virtuales"
  default     = "password_01"
}

variable "admin_user" {
  type        = string
  description = "Nombre d e usuario del administrador para el módulo de las máquinas virtuales"
  default     = "hector01"
}
