## VM Modules
resource "google_compute_instance" "jumper" {
  name         = "jumper"
  machine_type = "e2-micro"
  zone         = "${var.zone}"
  project      = "${var.project_id}"
  tags = ["jumper"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = "10"
    }
  }

  network_interface {
    network = "${var.network_name}"
    subnetwork = "${var.subnet_name}"
    
    access_config {
      nat_ip = google_compute_address.jumper.address
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
ari:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuIpE1H9vZYkF9e4kbZlpjthT77Nd/qoR5Rpl3/IUH9SGzg65DQzjeOhgqpAq933RhATGXW1h1SuLZNDGDw8ipu6UadUJyJNz2+1qVqVsOqsKMZGiSYpIJYAxeO7kvefq0T1O6/wz5yXshnDTqtLPjnsl0A2Sllb8mIASwUNPJYr4BbWcxhZUrOE3QwTXbqmSFo2N4b9ruBAu4cS8obf53HfOSDwBmjEPm8BtLAdwQwr/oq4AnkyayvkyGC4an8MNN8/xuxiiWFY4dEPtOpBYqHeIqJ5wxiUrvGgxwn/j3QXP1SjJStKHxl+T7NIbqRruTXYJzKi09ID0ZMrqdUI4f ari
    EOT
  }
  # service_account {
  #   email  = "teleport-db-service@ventures-auto-disbursement.iam.gserviceaccount.com"
  #   scopes = [
  #     "https://www.googleapis.com/auth/cloud-platform",
  #   ]
  # }
}

resource "google_compute_address" "jumper" {
  name = "jumper"
  project = "${var.project_id}"
  region = "${var.region}"
}

resource "google_compute_firewall" "allow-ssh-jumper" {
  
  name    = "allow-jumper-ssh"
  network = "${var.network_name}"
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["128.199.108.58/32","103.85.62.162/32","103.85.62.164/32","114.4.211.240/30","114.4.207.192/28","103.105.129.90/32","149.129.245.152/32"]
  target_tags = ["jumper"]
}

