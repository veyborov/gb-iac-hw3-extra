resource "google_compute_instance" "default" {
  name         = "gb-iac-hw3-additional-gitlab-ubuntu"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

#  metadata_startup_script = "sudo echo 'IyEvYmluL2Jhc2gNCiNJbnN0YWxsaW5nIGFkZGl0aW9uYWwgY29tcG9uZW50cw0Kc3VkbyBhcHQtZ2V0IHVwZGF0ZQ0Kc3VkbyBhcHQtZ2V0IGluc3RhbGwgLXkgY3VybCBvcGVuc3NoLXNlcnZlciBjYS1jZXJ0aWZpY2F0ZXMgdHpkYXRhIHBlcmwNCiNhZGRpbmcgZ2l0bGFiIHJlcG8NCmN1cmwgaHR0cHM6Ly9wYWNrYWdlcy5naXRsYWIuY29tL2luc3RhbGwvcmVwb3NpdG9yaWVzL2dpdGxhYi9naXRsYWItZWUvc2NyaXB0LmRlYi5zaCB8IHN1ZG8gYmFzaA0KI2luc3RhbGxpbmcgZ2l0bGFiIHdpdGggc3BlY2lhbCBwYXJhbWV0aGVycw0Kc3VkbyBFWFRFUk5BTF9VUkw9Imh0dHA6Ly8kKGN1cmwgLXMgLUggIk1ldGFkYXRhLUZsYXZvcjogR29vZ2xlIiBodHRwOi8vbWV0YWRhdGEvY29tcHV0ZU1ldGFkYXRhL3YxL2luc3RhbmNlL25ldHdvcmstaW50ZXJmYWNlcy8wL2FjY2Vzcy1jb25maWdzLzAvZXh0ZXJuYWwtaXApIiBhcHQtZ2V0IGluc3RhbGwgIC15IGdpdGxhYi1lZQ0KDQo=' | base64 -d > /tmp/install_gitlab.sh && sudo chmod +x /tmp/install_gitlab.sh && sudo sed -i -e 's/\r$//' /tmp/install_gitlab.sh && sudo /tmp/install_gitlab.sh"

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]
}

#resource "google_compute_firewall" "http-server" {
#  name    = "default-allow-http"
# network = "default"
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80"]
#  }
#
#  // Allow traffic from everywhere to instances with an http-server tag
#  source_ranges = ["0.0.0.0/0"]
#  target_tags   = ["http-server"]
#}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}