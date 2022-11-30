terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "3fc95c44-856c-4cf4-bba4-e47a118a15e0" 
  client_id = "736b4a43-569b-4821-83fa-ae64021824a7" 
  client_secret = "nXs8Q~HHvKwGKsRG2pJUZDzXcK27syqHW_wFeaQm" 
  tenant_id = "d1c80090-db78-4d4d-8950-d47ed6cc756b" 
  features {}
}

module "network_vpc_west" {
  source              = "./Modules/Network"
  location            = var.location
  proyecto            = var.proyecto
  entorno             = var.entorno
  network-subnet-cidr = var.subnet_cidr
  network-vnet-cidr   = var.vnet_cidr

}

module "VM" {
  depends_on = [
    module.network_vpc_west
  ]
  source                 = "./Modules/VM-SQL"
  network_resource_group = module.network_vpc_west.network_resource_group
  network_subnet         = module.network_vpc_west.network_subnet_id
  location               = var.location
  proyecto               = var.proyecto
  entorno                = var.entorno
  sql_admin_password     = var.admin_pass
  sql_admin_username     = var.admin_user

  generate_admin_ssh_key = false
  public                 = false

}

module "VM02" {
  source = "./Modules/VM-Global"
  depends_on = [
    module.network_vpc_west
  ]
  network_resource_group = module.network_vpc_west.network_resource_group
  network_subnet         = module.network_vpc_west.network_subnet_id
  location               = var.location
  proyecto               = var.proyecto
  entorno                = var.entorno
  sql_admin_password     = var.admin_pass
  sql_admin_username     = var.admin_user

  public                 = true
  generate_admin_ssh_key = true

}

module "k8" {
  source = "./Modules/K8"
  depends_on = [
    module.network_vpc_west
  ]
  location            = var.location
  name_resource_group = module.network_vpc_west.network_resource_group
}
