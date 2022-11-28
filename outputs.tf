output "ssh_key_vm_pem" {
  value    =  {for k, value in module.VM : k => value.ssh_key_vm_pem}
  sensitive = true
}

