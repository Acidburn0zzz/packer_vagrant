#!/bin/bash

# Allow root login
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# install additional packages
# openssl is needed to set root pw later
apt-get -y install leap-archive-keyring puppet lsb-release facter rsync curl openssl bash-completion wget sudo

# Don't use client locales
# https://stackoverflow.com/questions/29609371/how-do-not-pass-locale-through-ssh
sed 's/^AcceptEnv.*//' /etc/ssh/sshd_config


# Set root pw
usermod -p "$(echo vagrant | openssl passwd -1 -stdin)" root
