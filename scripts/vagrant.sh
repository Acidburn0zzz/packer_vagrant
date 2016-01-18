#!/bin/bash

# see https://docs.vagrantup.com/v2/boxes/base.html

# Vagrant specific
date > /etc/vagrant_box_build_time

# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /tmp/vagrant.pub

for user in vagrant root
do
  mkdir -pm 700 /home/${user}/.ssh
  chmod 0600 /home/${user}/.ssh/authorized_keys
  cp /tmp/vagrant.pub /home/${user}/.ssh/authorized_keys
  chown -R ${user} /home/${user}/.ssh
done

# configure password-less sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers


# Customize the message of the day
echo 'Development Environment' > /etc/motd
