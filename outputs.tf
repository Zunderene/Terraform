output "ssh_key_vm_pem_02" {
  value    =  module.VM02.ssh_key_vm_pem
  sensitive = true
}

output "ssh_key_vm_pem" {
  value    =  module.VM.ssh_key_vm_pem
  sensitive = true
}

