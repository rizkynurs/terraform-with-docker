module "network" {
  source               = "./modules/network"
  network_name         = var.network_name
  subnet_name          = var.subnet_name
  subnet_cidr          = var.subnet_cidr
  region               = var.region
  allow_ssh_cidr       = var.allow_ssh_cidr
  allow_http8080_cidr  = var.allow_http8080_cidr
}

module "compute" {
  source               = "./modules/compute"
  instance_name        = var.instance_name
  machine_type         = var.machine_type
  zone                 = var.zone
  ubuntu_image_family  = var.ubuntu_image_family
  ubuntu_image_project = var.ubuntu_image_project

  network_self_link    = module.network.network_self_link
  subnet_self_link     = module.network.subnet_self_link

  ssh_username         = var.ssh_username
  ssh_public_key       = var.ssh_public_key
}
