data "google_compute_image" "ubuntu" {
  family  = var.ubuntu_image_family
  project = var.ubuntu_image_project
}

# Read local files to inject into startup script
locals {
  docker_compose = file("${path.root}/../app/docker-compose.yml")
  env_example    = file("${path.root}/../app/.env.example")
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["sirclo-ssh", "sirclo-app"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = var.network_self_link
    subnetwork = var.subnet_self_link
    access_config {}
  }

  metadata = {
    "ssh-keys"       = "${var.ssh_username}:${var.ssh_public_key}"
    "startup-script" = templatefile("${path.module}/scripts/startup.sh.tftpl", {
      docker_compose = local.docker_compose
      env_example    = local.env_example
    })
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ]
  }
}
