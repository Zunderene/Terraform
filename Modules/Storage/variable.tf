variable "location" {
  type        = string
  description = "Localización de los recursos."
}

variable "name_resource_group" {
  type        = string
  description = "Nombre del grupo de recursos."
}

variable "account_tier" {
  type        = string
  description = "Nivel del storage account."
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  description = "Tipo de replicación del storage account."
  default     = "GRS"
}

variable "name_storage" {
  type        = string
  description = "Nombre del contenedor."
  default     = "copy"
}

variable "access_type" {
  type        = string
  description = "Tipo de acceso al contenedor."
  default     = "blob"
}
