terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Grupo de recurso
resource "azurerm_resource_group" "rg" {
  name     = var.name_resource_group
  location = var.location
}

# Módulo network
module "network" {
  source = "./Modules/Network"
  location = var.location
  name_resource_group = azurerm_resource_group.rg.name
  publicip_name = var.publicip_name
}

module "DB_Instance" {
  depends_on = [module.network]
  source = "./Modules/VM"
  location = var.location
  name_resource_group = azurerm_resource_group.rg.name
  sub1 = var.subnet1_name
  VPC = var.vnet_name
  ipPublic = var.publicip_name
}

# Módulo network
module "network_sub2" {
  source = "./Modules/Network"
  location = var.location
  name_resource_group = azurerm_resource_group.rg.name
  publicip_name = var.publicip_name
}

# Creación subred del recovery disaster
module "DB_Recovery_Disaster" {
  depends_on = [module.network_sub2]
  source = "./Modules/VM"
  location = var.location
  name_resource_group = azurerm_resource_group.rg.name
  subred = var.subnet2_name
  VPC = var.vnet_name
  ipPublic = var.publicip_name
}
