resource "google_compute_instance" "default" {
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

#  metadata_startup_script = "sudo echo '#!/bin/bash\n#Installing additional components\nsudo dnf install -y curl policycoreutils openssh-server perl\n#enabling and starting sshd\nsudo systemctl enable sshd && sudo systemctl start sshd\n#configuring firewalld\nsudo firewall-cmd --permanent --add-service=http\nsudo firewall-cmd --permanent --add-service=https\nsudo systemctl reload firewalld\n#pause to executing\nsleep 10\n#adding gitlab repo\ncurl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash\n#installing gitlab with special paramethers\nsudo EXTERNAL_URL="http://$(curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)" dnf install  -y gitlab-ee' > /tmp/install_gitlab.sh && sudo chmod +x /tmp/install_gitlab.sh && sudo /tmp/install_gitlab.sh"
  metadata_startup_script = "sudo echo '#!/bin/bash\n#Installing additional components\nsudo dnf install -y curl policycoreutils openssh-server perl\n#enabling and starting sshd\nsudo systemctl enable sshd && sudo systemctl start sshd\n' > /tmp/install_gitlab.sh && sudo chmod +x /tmp/install_gitlab.sh"
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