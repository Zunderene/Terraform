variable "agent_count" {
  default = 1
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "cluster_name" {
  default = "cluster_k8s"
}

variable "dns_prefix" {
  default = "clusterk8s"
}

# Refer to https://azure.microsoft.com/global-infrastructure/services/?products=monitor for available Log Analytics regions.
# variable "log_analytics_workspace_location" {
#  default = "eastus"
# }

# variable "log_analytics_workspace_name" {
# default = "testLogAnalyticsWorkspaceName"
# }

# Refer to https://azure.microsoft.com/pricing/details/monitor/ for Log Analytics pricing
# variable "log_analytics_workspace_sku" {
#  default = "PerGB2018"
#}

variable "location" {
  
}

variable "name_resource_group" {
  
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}