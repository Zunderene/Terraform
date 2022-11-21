#----------------------------------- MV ---------------------
variable "location" {
  
}

variable "name_resource_group" {
  
}

variable "sub1" {
  
}

variable "VPC" {
  
}

variable "ipPublic" {
  
}
variable "vm_name" {
  default = "VM_1"
}

variable "user_name" {
  default = "nombre_usuario" 
}

variable "user_password" {
  default = "password"
}

# Nombre de la NIC
variable "NIC_name1" {
  default     = "NIC1-Azure"
}

# Nombre de la configuración ip
variable "NIC_name_config" {
  default = "Nic-Config"
}