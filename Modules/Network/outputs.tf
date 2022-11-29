######################
## Network - Output ##
######################

output "network_vnet_id" {
  value = azurerm_virtual_network.Vnet.id
}

output "network_subnet_id" {
  value = azurerm_subnet.subnet.id
}