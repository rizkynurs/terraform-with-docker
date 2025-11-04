output "instance_external_ip" {
  value       = module.compute.instance_external_ip
  description = "External IP of the WordPress VM"
}

output "wordpress_url" {
  value       = "http://${module.compute.instance_external_ip}:8080"
  description = "URL to access the WordPress site"
}
