module "gke_main" {
    source = "../../modules/gke"

    # general variable
    project_id                      = local.project_id
    cluster_name                    = local.cluster_name
    region                          = local.region
    network_name                    = local.network_name
    subnet_name                     = local.subnet_name
    env                             = local.env

    # kubernetes variable       
    kubernetes_version              = local.kubernetes_version
    regional                        = local.regional
    gke_zones                       = local.gke_zones
    ip_range_pods_name              = local.ip_range_pods_name
    ip_range_svc_name               = local.ip_range_svc_name
    ip_range_master                 = local.ip_range_master
    master_authorized_network       = local.master_authorized_network
    
    # nodepool - tools
    tools_min_count                 = local.tools_min_count
    tools_initial_node_count        = local.tools_initial_node_count
    tools_max_count                 = local.tools_max_count
    tools_node_machine_type         = local.tools_node_machine_type
    tools_node_disk_size            = local.tools_node_disk_size
    tools_taints                    = local.tools_taints

    # nodepool - primary
    primary_pool_spot               = local.primary_pool_spot
    primary_min_count               = local.primary_min_count
    primary_initial_node_count      = local.primary_initial_node_count
    primary_max_count               = local.primary_max_count
    primary_node_machine_type       = local.primary_node_machine_type
    primary_node_disk_size          = local.primary_node_disk_size
    primary_taints                  = local.primary_taints

    # nodepool - secondary
    secondary_pool_spot             = local.secondary_pool_spot
    secondary_min_count             = local.secondary_min_count
    secondary_initial_node_count    = local.secondary_initial_node_count
    secondary_max_count             = local.secondary_max_count
    secondary_node_machine_type     = local.secondary_node_machine_type
    secondary_node_disk_size        = local.secondary_node_disk_size
    secondary_taints                = local.secondary_taints
}