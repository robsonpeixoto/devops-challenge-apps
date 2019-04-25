resource "azurerm_resource_group" "aks-rg" {
  name     = "akstest"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-slow"
  location            = "${azurerm_resource_group.aks-rg.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  dns_prefix          = "aks-slow"

  agent_pool_profile {
    name            = "default"
    count           = 2
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${var.id}"
    client_secret = "${var.secret}"
  }

  tags = {
    Environment = "aks-test"
  }
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
}
