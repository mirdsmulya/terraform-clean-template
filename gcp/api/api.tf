module "enabled_google_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"

  project_id                  = var.project_id
  disable_services_on_destroy = false

  activate_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "containerregistry.googleapis.com",
    "container.googleapis.com",
    "binaryauthorization.googleapis.com",
    "stackdriver.googleapis.com",
    "iap.googleapis.com",
    "servicenetworking.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "sourcerepo.googleapis.com",
    "cloudbuild.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudkms.googleapis.com"
  ]
}