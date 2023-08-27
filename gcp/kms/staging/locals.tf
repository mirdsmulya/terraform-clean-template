locals {
  # general variable
  project_id = "your-project-name"
  region = "asia-southeast2"

  # kms variable
  keyring = "vault-k8s-staging-keyring"
  keys = [
    "vault-k8s-staging-unseal-key",
    "vault-k8s-staging-key"
  ]

}