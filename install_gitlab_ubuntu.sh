#!/bin/bash
#Installing additional components
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
#adding gitlab repo
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
#installing gitlab with special paramethers
sudo EXTERNAL_URL="http://$(curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)" apt-get install  -y gitlab-ee

