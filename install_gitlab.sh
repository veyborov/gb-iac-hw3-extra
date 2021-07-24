#!/bin/bash
#Installing additional components
sudo dnf install -y curl policycoreutils openssh-server perl
#enabling and starting sshd
sudo systemctl enable sshd && sudo systemctl start sshd
#configuring firewalld
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld
#pause to executing
sleep 10
#adding gitlab repo
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash
#installing gitlab with special paramethers
sudo EXTERNAL_URL="http://$(curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)" dnf install  -y gitlab-ee

