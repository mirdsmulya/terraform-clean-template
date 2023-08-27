locals {
  ### -- WARNING -- Please dont change : 
  # cluster name
  # network
  # ip range. 
  ### it will be re create network and destroy all manifest

  # general variable
  project_id = "ventures-jastip"
  cluster_name = "jastip-staging"
  region = "asia-southeast2"
  network_name = "jastip-network"
  subnet_name = "jastip-staging-subnet"
  env = "staging"

  # kubernetes variable
  kubernetes_version = "1.24.14-gke.1800"
  regional = false
  gke_zones = ["asia-southeast2-a"]
  ip_range_pods_name = "ip-range-pods-staging"
  ip_range_svc_name = "ip-range-svc-staging"
  ip_range_master = "10.10.10.0/28"
  master_authorized_network = [
    {
      cidr_block   = "10.10.0.2/32"
      display_name = "Bastion Host"
    }
  ]
  
  # nodepool - tools
  tools_min_count = 0
  tools_initial_node_count = 0
  tools_max_count = 0
  tools_node_machine_type = "e2-custom-4-8192"
  tools_node_disk_size = 100
  tools_taints = [
      {
        key   = "tools-node"
        value = true
        effect= "NO_SCHEDULE"
      }
    ]

  # nodepool - primary
  primary_pool_spot = false
  primary_min_count = 1
  primary_initial_node_count = 1
  primary_max_count = 1
  primary_node_machine_type = "e2-custom-4-8192"
  primary_node_disk_size = 50
  primary_taints = [
      {
        key   = "primary-node"
        value = true
        effect= "PREFER_NO_SCHEDULE"
      }
    ]

  # nodepool - secondary
  secondary_pool_spot = true
  secondary_min_count = 1
  secondary_initial_node_count = 1
  secondary_max_count = 1
  secondary_node_machine_type = "e2-custom-4-8192"
  secondary_node_disk_size = 50
  secondary_taints = [
      {
        key   = "secondary-node"
        value = true
        effect= "PREFER_NO_SCHEDULE"
      }
    ]

}