# Azure virtual machine storage settings #

variable "network_resource_group" {}

variable "network_subnet" {}

variable "sql_delete_os_disk_on_termination" {
  type        = string
  description = "Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed?"
  default     = "true"  # Update for your environment
}

variable "sql_delete_data_disks_on_termination" {
  description = "Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed?"
  type        = string
  default     = "true" # Update for your environment
}


# Azure virtual machine OS profile #

variable "sql_admin_username" {
  description = "Username for Virtual Machine administrator account"
  type        = string
  default     = ""
}

variable "sql_admin_password" {
  description = "Password for Virtual Machine administrator account"
  type        = string
  default     = ""
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


variable "public" {
  type = bool
  default = false
}

variable "generate_admin_ssh_key" {
  type = bool
  default = false
}
