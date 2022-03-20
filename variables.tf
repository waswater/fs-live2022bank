variable resource_group_name {
    default = "recruitment-challange"
}

variable location {
    default = "West Europe"
}

# cluster vars

variable cluster_name {
    default = "recruitment-aks"
}

variable "dns_prefix" {
    default = "recruitment-dns-prefix"
}

# Tags

variable author_name {
    default = "FranciszekSzych"
}

variable default_env {
    default = "recruitment"
}

# Linux access for cluster nodes

variable "admin_user" {
    default = "aks_user"
    type = string
    description = "username for linux_profile"
}

variable "ssh_public_key" {
    description = "ssh_key for admin_user"
    default = "~/.ssh/id_rsa.pub"
}