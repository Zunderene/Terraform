output "ssh_key_vm_pem" {
  value    =  tls_private_key.ssh.private_key_pem
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}