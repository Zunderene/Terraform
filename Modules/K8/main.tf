# Creación del recurso del clúster de kubernetes.

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.name_resource_group.name
  dns_prefix          = var.dns_prefix
  tags = {
    Environment = var.tag_enviroment
  }

  # Definición de las opciones mínimas del clúster.
  default_node_pool {
    name       = var.default_var
    node_count = var.agent_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.subnet

  }

  # Configuración básica de la red para el clúster
  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.sku_lb
  }

  # Usar el sistema por defecto para la autenticación.
  identity {
    type = var.identity
  }
}
