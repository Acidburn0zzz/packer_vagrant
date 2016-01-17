#!/bin/bash

# Allow root login
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Set root pw
usermod -p "$(echo vagrant | openssl passwd -1 -stdin)" root
