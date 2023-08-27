# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

### -- WARNING -- Please dont change cluster name, network and ip range. it will be re create network and destroy all manifest ###
module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version    = "25.0.0"
  project_id = var.project_id
  name       = "${var.cluster_name}"

  region             = var.region
  regional           = var.regional
  network            = var.network_name
  zones              = var.gke_zones

  kubernetes_version = var.kubernetes_version

  release_channel = "STABLE"

  master_authorized_networks = var.master_authorized_network

  subnetwork        = var.subnet_name
  ip_range_pods     = "${var.ip_range_pods_name}"
  ip_range_services = "${var.ip_range_svc_name}"


  add_cluster_firewall_rules = true
  firewall_priority          = 1000
  firewall_inbound_ports = ["8443","9443","15017"]

  horizontal_pod_autoscaling = false
  http_load_balancing        = false

  network_policy = true

  maintenance_start_time = "02:00"

  remove_default_node_pool          = true

  cluster_autoscaling = {
    enabled             = true
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    max_cpu_cores       = 90
    min_cpu_cores       = 0
    max_memory_gb       = 90
    min_memory_gb       = 0
    gpu_resources       = []
    auto_repair         = true
    auto_upgrade        = true
  }

  node_pools = [
    {
      ## This pool is for tools, system and etc outside of apps ( needs on demand node )
      name               = "tools-node-pool"
      min_count          = var.tools_min_count
      initial_node_count = var.tools_initial_node_count
      max_count          = var.tools_max_count
      auto_upgrade       = true
      node_metadata      = "GKE_METADATA"

      machine_type    = var.tools_node_machine_type
      local_ssd_count = 0
      disk_size_gb    = var.tools_node_disk_size
      disk_type       = "pd-ssd"
      image_type      = "cos_containerd"
      auto_repair     = true
      preemptible     = false
      autoscaling     = true
    },
    {
      ## Primary pool for the Application ( better on demand node )
      name               = "primary-node-pool"
      min_count          = var.primary_min_count
      initial_node_count = var.primary_initial_node_count
      max_count          = var.primary_max_count
      auto_upgrade       = true
      node_metadata      = "GKE_METADATA"

      machine_type    = var.primary_node_machine_type
      local_ssd_count = 0
      disk_size_gb    = var.primary_node_disk_size
      disk_type       = "pd-standard"
      image_type      = "cos_containerd"
      auto_repair     = true
      preemptible     = false
      autoscaling     = true
      spot            = var.primary_pool_spot
    },
    {
      # Secondary pool for the Application ( spot instance recommended )
      name            = "secondary-node-pool"
      machine_type    = var.secondary_node_machine_type
      min_count          = var.secondary_min_count
      initial_node_count = var.secondary_initial_node_count
      max_count          = var.secondary_max_count
      auto_upgrade    = true
      node_metadata   = "GKE_METADATA"

      machine_type    = var.secondary_node_machine_type
      local_ssd_count = 0
      disk_size_gb    = var.secondary_node_disk_size
      disk_type       = "pd-standard"
      image_type      = "cos_containerd"
      auto_repair     = true
      preemptible     = false
      autoscaling     = true
      spot            = var.secondary_pool_spot
    },
  ]

  node_pools_labels = {
    all = {
      default-node-pool = true
      cluster           = var.cluster_name
      env               = var.env
      managed_by        = "terraform"
    }

    primary-node-pool = {
      secondary-node-pool = true
    }

    secondary-node-pool = {
      secondary-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {
      shutdown-script = file("${path.module}/data/shutdown-script.sh")
    }
  }

  node_pools_tags = {
    all = [
      "all-${var.cluster_name}"
    ]

    tools-node-pool = [
      "tools-node-pool",
    ]

    primary-node-pool = [
      "primary-node-pool",
    ]

    secondary-node-pool = [
       "secondary-node-pool"
    ]
  }

  node_pools_taints = {
    all = []

    tools-node-pool = var.tools_taints

    primary-node-pool= var.primary_taints

    secondary-node-pool = var.secondary_taints
  }

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
    ]
  }

  logging_service    = "none"
  monitoring_service = "none"

  create_service_account = true
  grant_registry_access  = true

  cluster_resource_labels = {
    cluster    = var.cluster_name
    env        = var.env
    managed_by = "terraform"
  }

  enable_private_endpoint       = true
  deploy_using_private_endpoint = true

  enable_private_nodes = true

  master_ipv4_cidr_block = var.ip_range_master

  enable_binary_authorization = true
}