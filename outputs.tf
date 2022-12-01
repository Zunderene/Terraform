output "VMS" {
  value    =  {for k, value in module.VM : k => value}
  sensitive = true
}

#output "K8S" {
#  value = module.k8.kube_ip_private
#  sensitive = true
#}

