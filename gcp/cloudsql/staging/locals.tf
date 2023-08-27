locals {
  # ----------------------------
  # General Variable
  # ----------------------------
  project_id = "ventures-jastip"
  region = "asia-southeast2"
  network_name = "jastip-network"
  env = "staging"


  # ----------------------------
  # Cloudsql Related Variable
  # ----------------------------
  cloudsql_name = "jastip-staging"
  delete_protection = true
  database_version = "POSTGRES_14"
  tier_spec = "db-f1-micro"
  availability_type = "ZONAL"
  disk_size = "50"
  initial_db_name = "jastip"
  initial_db_user = "jastip-user"
}