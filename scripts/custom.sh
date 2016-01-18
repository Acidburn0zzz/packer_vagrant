#!/bin/bash

# Allow root login
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# install additional packages
# openssl is needed to set root pw later
apt-get -y install puppet lsb-release facter rsync curl openssl

# Set root pw
usermod -p "$(echo vagrant | openssl passwd -1 -stdin)" root
