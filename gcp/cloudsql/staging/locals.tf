locals {
  # ----------------------------
  # General Variable
  # ----------------------------
  project_id = "your-project-name"
  region = "asia-southeast2"
  network_name = "cluster-network"
  env = "staging"


  # ----------------------------
  # Cloudsql Related Variable
  # ----------------------------
  cloudsql_name = "cloudsql-staging"
  delete_protection = true
  database_version = "POSTGRES_14"
  tier_spec = "db-f1-micro"
  availability_type = "ZONAL"
  disk_size = "50"
  initial_db_name = "db1"
  initial_db_user = "db-user"
}