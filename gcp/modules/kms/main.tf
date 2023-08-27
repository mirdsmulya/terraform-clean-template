module "kms_vault_k8s" {
  source  = "terraform-google-modules/kms/google"
  version = "2.1.0"

  project_id         = var.project_id
  location           = var.region
  keyring            = "${var.keyring}"
  keys               = var.keys
}