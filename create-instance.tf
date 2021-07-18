resource "google_compute_instance" "default3" {
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

    metadata_startup_script = "sudo dnf install -y curl policycoreutils openssh-server perl && sudo systemctl enable sshd && sudo systemctl start sshd && sudo firewall-cmd --permanent --add-service=http && sudo firewall-cmd --permanent --add-service=https && sudo systemctl reload firewalld && sleep 10 && curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash && sleep 10 && sudo dnf install -y gitlab-ee"

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

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "ip" {
  value = "${google_compute_instance.default3.network_interface.0.access_config.0.nat_ip}"
}
