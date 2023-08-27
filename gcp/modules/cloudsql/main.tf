resource "google_sql_database_instance" "cloudsql" {
  name   = "${var.cloudsql_name}"
  database_version = "${var.database_version}"
  region = "${var.region}"
  project = "${var.project_id}"
  deletion_protection = var.delete_protection

  settings {
    tier = "${var.tier_spec}"
    availability_type = "${var.availability_type}"
    disk_size = "${var.disk_size}"

    user_labels = {
      "env" = "${var.env}"
    }

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.project_id}/global/networks/${var.network_name}"
    }

    backup_configuration {
      enabled    = true
      point_in_time_recovery_enabled = false
      location = "asia"
    }

    # maintenance_window {
    #   day  = 0
    #   hour = 0
    # }
  }
}

resource "google_sql_database" "cloudsql" {
  project = "${var.project_id}"
  name     = "${var.initial_db_name}"
  instance = google_sql_database_instance.cloudsql.name
}

resource "random_password" "cloudsql" {
  length = 16
  special = true
  override_special = "-_*{}"
}

resource "google_sql_user" "cloudsql" {
  project = "${var.project_id}"
  name     = "${var.initial_db_user}"
  instance = google_sql_database_instance.cloudsql.name
  password = random_password.cloudsql.result
}

output "password_sql" {
  value = random_password.cloudsql.result
}
