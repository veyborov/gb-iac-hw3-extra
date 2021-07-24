resource "google_compute_instance" "default4" {
  name         = "gb-iac-hw3-additional-gitlab"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

    metadata_startup_script = "./install_gitlab.sh"

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]
}

#resource "google_compute_firewall" "http-server" {
#  name    = "default-allow-http-gitlab"
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
  value = "${google_compute_instance.default4.network_interface.0.access_config.0.nat_ip}"
}
