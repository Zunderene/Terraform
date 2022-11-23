terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
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

# Grupo de recurso
resource "azurerm_resource_group" "rg" {
  name     = var.name_resource_group
  location =  var.location[0]
}

# Creación de IP pública
resource "azurerm_public_ip" "publicIP" {
  depends_on = [
    azurerm_resource_group.rg
  ]
    name                         =  var.publicip_name
    location                     =  var.location[0]
    resource_group_name          = "${var.name_resource_group}"
    allocation_method            = "Static"
    sku                          = "Standard"
}

module "network_vpc_west" {
  depends_on = [
    resource.azurerm_public_ip.publicIP
  ]
  source = "./Modules/Network"
  location = var.location[0]
  subred = var.subnet
  vnet_name = var.vnet_name
  name_resource_group = azurerm_resource_group.rg.name
  public_ip_id = azurerm_public_ip.publicIP.id
}

module "DB_Instance" {
  depends_on = [module.network_vpc_west]
  source = "./Modules/VM"
  location = var.location[0]
  name_resource_group = azurerm_resource_group.rg.name
  subred = var.subnet
  vnet_name = var.vnet_name
  public_ip_id = azurerm_public_ip.publicIP.id

}

module "Recovery" {
  depends_on = [module.network_vpc_west]
  source = "./Modules/VM"
  vm_name = "recovery"
  NIC_name1 = "recovery-nic"

  location = var.location[0]
  name_resource_group = azurerm_resource_group.rg.name
  subred = var.subnet
  vnet_name = var.vnet_name
  public_ip_id = azurerm_public_ip.publicIP.id

}

module "storage" {
  source = "./Modules/Storage"
  depends_on = [
    azurerm_resource_group.rg
  ]
  name_resource_group = var.name_resource_group
  location =  var.location[0]
}

#module "K8s" {
#  depends_on = [module.network_vpc_west]
#  source = "./Modules/K8"
#  name_resource_group = var.name_resource_group
#  location =  var.location[0]
#
#}
