variable "project_id" { 
    type = string  
    description = "GCP Project ID" 
}

variable "region" { 
    type = string  
    default = "asia-southeast2"  
    description = "GCP region (default: asia-southeast2 - Jakarta)" 
}

variable "zone" { 
    type = string  
    default = "asia-southeast2-a"  
    description = "GCP zone (default: asia-southeast2-a)" 
}

variable "network_name" { 
    type = string  
    default = "sirclo-vpc"  
    description = "VPC network name" 
}

variable "subnet_name"  { 
    type = string  
    default = "sirclo-subnet-public"  
    description = "Public subnet name" 
}

variable "subnet_cidr"  { 
    type = string  
    default = "10.10.0.0/24"  
    description = "CIDR range for the public subnet" 
}

variable "instance_name" { 
    type = string  
    default = "sirclo-wp-vm"  
    description = "Compute Engine VM name" 
}

variable "machine_type" { 
    type = string  
    default = "e2-micro"  
    description = "Instance type" 
}

variable "ubuntu_image_family"  { 
    type = string  
    default = "ubuntu-2204-lts"  
    description = "Ubuntu image family" 
}

variable "ubuntu_image_project" { 
    type = string  
    default = "ubuntu-os-cloud"  
    description = "Ubuntu image project" 
}

variable "ssh_username" { 
    type = string  
    description = "Linux username to associate with the SSH public key" 
}

variable "ssh_public_key" { 
    type = string  
    description = "SSH public key (e.g., 'ssh-rsa AAAA... user@host')" 
}

variable "allow_ssh_cidr" { 
    type = string  
    default = "0.0.0.0/0"  
    description = "CIDR allowed for SSH (port 22)" 
}

variable "allow_http8080_cidr" { 
    type = string  
    default = "0.0.0.0/0"  
    description = "CIDR allowed for app (port 8080)" 
}
