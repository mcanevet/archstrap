class arch::config::bootloader {
  file { '/etc/mkinitcpio.conf':
    ensure => file,
    mode   => '0444', # Force a notify
    notify => Exec['mkinitcpio'],
  }
  exec { 'mkinitcpio':
    command     => 'mkinitcpio -p linux',
    path        => $::path,
    refreshonly => true,
    notify      => Exec['grub-install'],
  }
  exec { 'grub-install':
    command     => 'grub-install --target=i386-pc --recheck /dev/sda',
    path        => $::path,
    refreshonly => true,
    notify      => Exec['grub-mkconfig'],
  }
  exec { 'grub-mkconfig':
    command     => 'grub-mkconfig -o /boot/grub/grub.cfg',
    path        => $::path,
    refreshonly => true,
  }
}
