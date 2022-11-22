#----------------------------------- MV ---------------------
variable "location" {
  
}

variable "name_resource_group" {
  
}

variable "subred" {
  
}

variable "vnet_name" {
  
}

variable "public_ip_id" {
  
}

variable "vm_name" {
  default = "maquina01"
}

variable "vm_name2" {
  default = "maquina02"
}

variable "user_name" {
  default = "nombre_usuario" 
}

variable "user_password" {
  default = "Password01"
}

# Nombre de la NIC
variable "NIC_name1" {
  default     = "NIC1-Azure"
}

variable "NSG_name" {
  default="segurity-group"
}

# Nombre de la configuración ip
variable "NIC_name_config" {
  default = "Nic-Config"
}