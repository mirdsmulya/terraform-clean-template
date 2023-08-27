locals {
  # general variable
  project_id = "ventures-jastip"
  region = "asia-southeast2"

  # kms variable
  keyring = "dana-ventures-jastip-vault-k8s-staging-keyring"
  keys = [
    "dana-ventures-jastip-vault-k8s-staging-unseal-key",
    "dana-ventures-jastip-vault-k8s-staging-key"
  ]

}