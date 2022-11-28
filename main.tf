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
