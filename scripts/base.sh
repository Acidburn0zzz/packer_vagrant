#!/bin/bash

# setup locales
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set up apt repos
echo -e "deb http://deb.debian.org/debian/ jessie main\ndeb http://security.debian.org/ jessie/updates main" > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ jessie-backports main" > /etc/apt/sources.list.d/backports.list

# Add LEAP debian repo
echo 'deb http://deb.leap.se/0.9 jessie main' > /etc/apt/sources.list.d/leap.list

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
