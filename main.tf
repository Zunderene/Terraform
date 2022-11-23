terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.59.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "d154b22a-00e9-4d61-bccd-1c77b06247da" 
  client_id = "df4f9529-a125-4b6c-aed4-23b11c85efcf" 
  client_secret = "hbW8Q~Uh2SQ~T9lAnhCmj6IqC50rYaAUXOOZ.cTC" 
  tenant_id = "b904303e-f6ca-40b3-9015-8948e09309bf" 
  features {}
}



module "network_vpc_west" {
  source = "./Modules/Network"
  location = var.location
  proyecto = var.proyecto
  entorno  = var.entorno
  network-subnet-cidr = "10.128.1.0/24"
  network-vnet-cidr = "10.128.0.0/16"

}


module "VM" {
  source = "./Modules/VM-SQL"
  network_resource_group = module.network_vpc_west.network_resource_group
  network_subnet = module.network_vpc_west.network_subnet_id
  location = var.location
  proyecto = var.proyecto
  entorno  = var.entorno
  sql_admin_password = "password_01"
  sql_admin_username = "hector01"

  generate_admin_ssh_key = false
  public = false

}

module "VM02" {
  source = "./Modules/VM-SQL"
  network_resource_group = module.network_vpc_west.network_resource_group
  network_subnet = module.network_vpc_west.network_subnet_id
  location = var.location
  proyecto = var.proyecto
  entorno  = var.entorno
  sql_admin_password = "password_01"
  sql_admin_username = "hector01"

  public = true
  generate_admin_ssh_key = true

}

module "k8" {
  source = "./Modules/K8"
  depends_on = [
    module.network_vpc_west
  ]
  location = var.location
  name_resource_group = module.network_vpc_west.network_resource_group

}
module "storage" {
  depends_on = [
    module.network_vpc_west
  ]
  source = "./Modules/Storage"
  location = var.location
  name_resource_group = module.network_vpc_west.network_resource_group.name
}
