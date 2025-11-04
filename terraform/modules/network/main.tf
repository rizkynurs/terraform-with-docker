resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.network_name}-allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction   = "INGRESS"
  source_ranges = [var.allow_ssh_cidr]
  target_tags = ["sirclo-ssh"]
}

resource "google_compute_firewall" "allow_8080" {
  name    = "${var.network_name}-allow-8080"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  direction   = "INGRESS"
  source_ranges = [var.allow_http8080_cidr]
  target_tags = ["sirclo-app"]
}
