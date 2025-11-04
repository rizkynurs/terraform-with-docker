# Cloud Infra Ops – WordPress on GCP (Terraform + Docker Compose)

Provision GCP infrastructure (VPC, subnet, firewall, e2-micro VM on Ubuntu 22.04) and auto-deploy a WordPress + MySQL stack via Docker Compose on first boot.

## Architecture
- **VPC** with a **public subnet**
- **Firewall** rules: TCP 22 (SSH) and TCP 8080 (app) open to 0.0.0.0/0
- **Compute Engine**: `e2-micro` (free-tier eligible), Ubuntu 22.04 LTS
- **Startup Script** installs Docker & Compose, writes `docker-compose.yml` and `.env`, and runs `docker compose up -d`
- **WordPress** reachable at `http://<VM_PUBLIC_IP>:8080`

---

## Prerequisites
- **Terraform** >= 1.6.0
- **gcloud CLI** authenticated to your GCP account (`gcloud auth application-default login` or `gcloud auth login --no-launch-browser`)
- A **GCP project** with billing enabled
- A **SSH public key** to allow SSH into the VM

---

## Configuration

1. Set your active project and default region/zone (optional but recommended):
   ```bash
   gcloud config set project <YOUR_PROJECT_ID>
   gcloud config set compute/region asia-southeast2
   gcloud config set compute/zone asia-southeast2-a
   ```

2. Create this file `terraform/terraform.tfvars` if not existed, specify values:
   ```hcl
   project_id     = "<YOUR_PROJECT_ID>"
   region         = "asia-southeast2"
   zone           = "asia-southeast2-a"
   ssh_username   = "ubuntu"
   ssh_public_key = "<contents of ~/.ssh/id_rsa.pub>"
   ```
---

## Deployment Steps

```bash
cd terraform
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

When complete, Terraform will output:
- `instance_public_ip`
- `wordpress_url`

Visit the `wordpress_url` in your browser.

> **First-boot note:** The startup script installs Docker, pulls images, and launches containers. Allow ~5–10 minutes for WordPress to become reachable.

---

## Verification

- From your machine: open `http://<PUBLIC_IP>:8080`
- Via SSH (replace IP):
  ```bash
  ssh ubuntu@<PUBLIC_IP>
  sudo docker ps
  sudo docker compose -f /opt/wordpress/docker-compose.yml --env-file /opt/wordpress/.env ps
  curl -I http://localhost:8080
  ```

---

## Cleanup

Destroy all resources:
```bash
cd terraform
terraform destroy -auto-approve
```

This will remove the VM, VPC, subnet, and firewall rules.

---
