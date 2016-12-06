#!/bin/bash

# Allow root login
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# install additional packages
# LEAP people like some of these: see also #6898 and https://github.com/leapcode/leap_cli/pull/17

apt-get -y install leap-archive-keyring puppet lsb-release facter rsync curl bash-completion wget sudo unzip vim tmux ntp git rdoc

# Don't use client locales
# https://stackoverflow.com/questions/29609371/how-do-not-pass-locale-through-ssh
sed 's/^AcceptEnv.*//' /etc/ssh/sshd_config

# Set root pw
echo 'root:vagrant' | chpasswd 
