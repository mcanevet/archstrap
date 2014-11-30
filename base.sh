#!/usr/bin/env bash
/bin/arch-chroot /mnt <<SCRIPT

echo 'Set up the initial RAMdisk'
mkinitcpio -p linux

echo 'Ensure dhcpcd starts on boot'
systemctl enable dhcpcd.service

echo Create 'vagrant' user
useradd vagrant
mkdir /home/vagrant
mkdir /home/vagrant/.ssh

echo 'Fix permissions on vagrant keys.'
chown -R vagrant /home/vagrant/
chmod 700 /home/vagrant/.ssh/
chmod 600 /home/vagrant/.ssh/authorized_keys

echo 'Install sudo'
pacman --noconfirm -S sudo

echo 'add vagrant to the sudoers list'
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10-vagrant

echo 'Install bootloader'
pacman --noconfirm -S grub
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo 'ensure ssh is installed'
pacman -S --noconfirm openssh
systemctl enable sshd.service

echo 'set up the virtualbox guest additions'
pacman -S --noconfirm virtualbox-guest-utils

mkdir -p /etc/modules-load.d
cat <<CONF>/etc/modules-load.d/virtualbox.conf
vboxguest
vboxsf
vboxvideo
CONF

echo 'install puppet'
pacman -S --noconfirm puppet

SCRIPT
