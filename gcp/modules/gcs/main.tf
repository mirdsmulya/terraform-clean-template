resource "google_storage_bucket" "bucket" {
  name          = "${var.bucket_name}"
  location      = "${var.region}"
  force_destroy = false

  uniform_bucket_level_access = true

  cors {
    max_age_seconds = 3600
    method          = [ "PUT", "POST", "GET", "HEAD" ]
    origin          = [ "*" ]
    response_header = [ "Content-Type", "x-goog-resumable" ]
  }
}