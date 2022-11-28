#############################
## aplicacion - Variables ##
#############################

# Nombre del proyecto.

variable "proyecto" {
  type = string
  description = "Este nombre se usa para nombrar todos los recursos"
  default = "jira"
}

# Entorno
variable "entorno"{
  type = string
  description = "Esta variable indica de que modulo fue procesado"
  default="jira"
}

variable "__location__" {}
variable "__gruporesource__" {}
variable "__network-vnet-cidr__" {}
variable "__network-subnet-cidr__" {}

variable "__maquinas__" {
 
  
  default = {
    "VM01" = {
    name = "maquina01"
    location = ""
    resource_group_name = ""
    size = ""
    source_image_offer = ""
    source_image_publisher = ""
    os_disk_storage_account = ""
    storage_account_type = ""
    admin_username = ""
    kernel_type = ""
    securities_rule_vm = {}
    
  },
  "VM02" = {
    name = "maquina02"
    location = ""
    resource_group_name = ""
    size = ""
    source_image_offer = ""
    source_image_publisher = ""
    os_disk_storage_account = ""
    storage_account_type = ""
    admin_username = ""
    kernel_type = ""
    securities_rule_vm ={}
    
  }
  }
}







