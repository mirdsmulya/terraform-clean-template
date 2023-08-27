module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"
  project_id   = var.project_id
  network_name = "${var.cluster_name}-network"
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name           = "${var.cluster_name}-staging-subnet"
      subnet_ip             = var.subnet_ip_staging
      subnet_region         = var.region
      subnet_private_access = true
      description           = "Staging environment - This subnet is managed by Terraform"
    },
    {
      subnet_name           = "${var.cluster_name}-production-subnet"
      subnet_ip             = var.subnet_ip_production
      subnet_region         = var.region
      subnet_private_access = true
      description           = "Production environment - This subnet is managed by Terraform"
    }
  ]

  secondary_ranges = {
    "${var.cluster_name}-staging-subnet" = [
      {
        range_name    = "ip-range-pods-staging"
        ip_cidr_range = var.ip_range_pods_staging
      },
      {
        range_name    = "ip-range-svc-staging"
        ip_cidr_range = var.ip_range_svc_staging
      },
    ],
    "${var.cluster_name}-production-subnet" = [
      {
        range_name    = "ip-range-pods-production"
        ip_cidr_range = var.ip_range_pods_production
      },
      {
        range_name    = "ip-range-svc-production"
        ip_cidr_range = var.ip_range_svc_production
      },
    ]
  }
}

module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  project_id    = var.project_id
  region        = var.region
  router        = "${var.cluster_name}-router"
  network       = module.vpc.network_self_link
  create_router = true
}

resource "google_compute_global_address" "google-managed-service-range" {
  project = var.project_id
  name = "google-managed-services"
  purpose = "VPC_PEERING"
  prefix_length = 16
  address_type = "INTERNAL"
  network = module.vpc.network_self_link
}

resource "google_service_networking_connection" "private-service-access" {
  network = module.vpc.network_self_link
  reserved_peering_ranges = [google_compute_global_address.google-managed-service-range.name]
  service = "servicenetworking.googleapis.com"
  depends_on = [google_compute_global_address.google-managed-service-range]
}

 # enable apis
 resource "google_project_service" "vpcaccess-api" {
   project = var.project_id # Replace this with your project ID in quotes
   service = "vpcaccess.googleapis.com"
 }
