# ----------------------------
# General Variable
# ----------------------------
variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
    type = string
}

variable "env" {
  type = string
}


# ----------------------------
# Kubernetes Related Variable
# ----------------------------
variable "kubernetes_version" {
  type        = string
  default     = "latest"
}

variable "regional" {
  type = bool
}

variable "gke_zones" {
  type = list
  default = ["asia-southeast2-a","asia-southeast2-b","asia-southeast2-c"]
}
variable "ip_range_pods_name" {
  type = string
}

variable "ip_range_svc_name" {
  type = string
}

variable "ip_range_master" {
  type = string
}

variable "master_authorized_network" {
  description = "network that authorized to access master"
  type = list(
    object(
      {
        cidr_block   = string
        display_name = string
      }
    )
  )  
}

# ----------------------------
# Nodepool - Tools
# ----------------------------
variable "tools_min_count" {
  default = 1
}

variable "tools_initial_node_count" {
  default = 1
}

variable "tools_max_count" {
  default = 1
}

variable "tools_node_machine_type" {
  default = "e2-custom-4-8192"
}

variable "tools_node_disk_size" {
  default = 100
}

variable "tools_taints" {
  description = "taint on tools node"
  type = list(
    object(
      {
        key   = string
        value = string
        effect= string
      }
    )
  )  
}

# ----------------------------
# Nodepool - Primary 
# ----------------------------
variable "primary_pool_spot" {
  default = false
}

variable "primary_min_count" {
  default = 1
}

variable "primary_initial_node_count" {
  default = 1
}

variable "primary_max_count" {
  default = 1
}

variable "primary_node_machine_type" {
  default = "e2-custom-4-8192"
}

variable "primary_node_disk_size" {
  default = 50
}

variable "primary_taints" {
  description = "taint on primary node"
  type = list(
    object(
      {
        key   = string
        value = string
        effect= string
      }
    )
  ) 
}


# ----------------------------
# Nodepool - Secondary
# ----------------------------
variable "secondary_pool_spot" {
  default = true
}

variable "secondary_min_count" {
  default = 1
}

variable "secondary_initial_node_count" {
  default = 1
}

variable "secondary_max_count" {
  default = 1
}

variable "secondary_node_machine_type" {
  default = "e2-custom-4-8192"
}

variable "secondary_node_disk_size" {
  default = 50
}

variable "secondary_taints" {
  description = "taint on secondary node"
  type = list(
    object(
      {
        key   = string
        value = string
        effect= string
      }
    )
  )  
}