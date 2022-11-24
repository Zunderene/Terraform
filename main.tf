terraform {
   backend "azurerm" {
    storage_account_name = "__terraformstorageaccount__"
    container_name       = "__terraformcontainer__"
    key                  = "__terraformtfstatefile__"
    access_key           = "__storagekey__"
    features{
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
  }
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
  depends_on = [
    module.network_vpc_west
  ]
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
  source = "./Modules/VM"
  depends_on = [
    module.network_vpc_west
  ]
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
