variable "agent_count" {
  default     = 1
  description = "Contador para la cantidad de clústeres a crear."
}

variable "default_var" {
  type        = string
  default     = "default"
  description = "Variable default."
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2_v2"
  description = "Tamaño del clúster a crear."
}

# Las siguientes dos variablese son referencias de marcador de posición.
# Modifica el varlo de estas en terraform.tfvars
variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "cluster_name" {
  type        = string
  default     = "cluster_k8s"
  description = "Nombre del clúster a crear."
}

variable "dns_prefix" {
  type        = string
  default     = "clusterk8s"
  description = "Prefijo a usar en el dns."
}

variable "network_plugin" {
  type        = string
  default     = "kubenet"
  description = "Perfil de la red. Si no está definida, por defecto es kubenet."
}

variable "sku_lb" {
  type        = string
  default     = "standard"
  description = "Especifica el SKU del load balancer usado por el clúster."
}

variable "identity" {
  type        = string
  default     = "SystemAssigned"
  description = "Especifica el sisstema por defecto de autenticación."
}

variable "location" {
  type        = string
  description = "Localización del recurso creado"
}

variable "name_resource_group" {
  #type        = string
  #description = "Nombre asignado al grupo de recursos."
}

variable "subnet" {
  
}

variable "ssh_public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Ruta de la ssh pública."
}

variable "tag_enviroment" {
  type        = string
  default     = "K8S"
  description = "Tag para la creación del clúster"
}
