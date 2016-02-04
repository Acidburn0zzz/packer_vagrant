#!/bin/bash

# Allow root login
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# install additional packages
apt-get -y install puppet lsb-release facter rsync curl

# Set root pw
echo 'root:vagrant' | chpasswd 
