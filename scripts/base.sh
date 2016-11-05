#!/bin/bash

perl -p -i -e 's#http://us.archive.ubuntu.com/ubuntu#http://mirror.rackspace.com/ubuntu#gi' /etc/apt/sources.list

# Update the box
apt-get -y update >/dev/null
apt-get -q -y -o \'DPkg::Options::=--force-confold\' dist-upgrade

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Only update grub when it's installed (lxc won't have it
if [ -e /usr/sbin/update-grub ]
then
  # Remove 5s grub timeout to speed up booting
  # Heredoc NEEDS to be indented with tabs not spaces
  # https://unix.stackexchange.com/questions/76481/cant-indent-heredoc-to-match-nestings-indent
  cat <<-EOF > /etc/default/grub
		# If you change this file, run 'update-grub' afterwards to update
		# /boot/grub/grub.cfg.

		GRUB_DEFAULT=0
		GRUB_TIMEOUT=0
		GRUB_DISTRIBUTOR=$(lsb_release -i -s 2> /dev/null || echo Debian)
		GRUB_CMDLINE_LINUX_DEFAULT="quiet"
		GRUB_CMDLINE_LINUX="debian-installer=en_US"
		EOF

  update-grub
fi
