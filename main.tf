provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "recruitment-challange" {
  name     = var.resource_group_name
  location = var.location

    tags = {
        env = var.default_env
        name  = var.author_name
    }
}

resource "azurerm_virtual_network" "recruitment-vnet" {
  name                = "recruitment-vnet"
  address_space       = ["10.0.10.0/23"]
  location            = azurerm_resource_group.recruitment-challange.location
  resource_group_name = azurerm_resource_group.recruitment-challange.name

    tags = {
        env = var.default_env
        name  = var.author_name
    }
}

resource "azurerm_subnet" "recruitment-subnet" {
    name                 = "recruitment-subnet"
    resource_group_name  = azurerm_resource_group.recruitment-challange.name
    virtual_network_name = azurerm_virtual_network.recruitment-vnet.name
    address_prefixes     = ["10.0.10.0/24"]
}



resource "azurerm_kubernetes_cluster" "recruitment-aks" {
    name                = var.cluster_name
    location            = azurerm_resource_group.recruitment-challange.location
    resource_group_name = azurerm_resource_group.recruitment-challange.name
    dns_prefix          = var.dns_prefix
    role_based_access_control_enabled = true

    default_node_pool {
        name                = "recuitmentpool"
        enable_auto_scaling = true
        vm_size             = "Standard_D2_v2"
        availability_zones  = ["1", "2", "3"]
        min_count           = 3
        max_count           = 10
        os_disk_size_gb     = 256
        pod_subnet_id       = azurerm_subnet.recruitment-subnet.id
    }


    identity {
        type = "SystemAssigned"
    }

    network_profile {
        network_plugin = "azure"
        dns_service_ip = "10.254.0.10"
        docker_bridge_cidr = "172.17.0.1/16"
        service_cidr = "10.254.0.0/16"
    }

    auto_scaler_profile {
        scale_down_utilization_threshold = 0.8
        skip_nodes_with_system_pods = false
        skip_nodes_with_local_storage = false
    }

    # That was not required, but might be useful to have a way to ssh into the cluster nodes in case something goes wrong
    linux_profile {
        admin_username = var.admin_user

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    tags = {
        env = var.default_env
        name  = var.author_name
    }
}
