terraform {


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


provider "azurerm" {
   subscription_id = "d154b22a-00e9-4d61-bccd-1c77b06247da" 
  client_id = "df4f9529-a125-4b6c-aed4-23b11c85efcf" 
  client_secret = "hbW8Q~Uh2SQ~T9lAnhCmj6IqC50rYaAUXOOZ.cTC" 
  tenant_id = "b904303e-f6ca-40b3-9015-8948e09309bf" 
  features {}
}

module "network_vpc_west" {
  source = "./Modules/Network"
  location = var.__location__
  network-subnet-cidr = var.__network-subnet-cidr__
  network-vnet-cidr = var.__network-vnet-cidr__
  entorno = "cloud"
  proyecto = "jira"

}

module "VM" {
  depends_on = [
    module.network_vpc_west
  ]
  source = "./Modules/VM-Global"

  for_each = var.__maquinas__

    name = each.key
    source_image_offer =  each.value.source_image_offer
    source_image_publisher =  each.value.source_image_publisher
    storage_account_type = each.value.storage_account_type
    admin_username = each.value.admin_username
    location = each.value.location
    size = each.value.size
    if_public_ip = each.value.if_public_ip
    securities_rule_vm = each.value.securities_rule_vm


  network_resource_group_name = module.network_vpc_west.network_resource_group.name
  network_subnet = module.network_vpc_west.network_subnet_id


}

#module "k8" {
#  source = "./Modules/K8"
#  depends_on = [
#    module.network_vpc_west
#  ]
#  location = var.__location__
#  name_resource_group = module.network_vpc_west.network_resource_group

#}
