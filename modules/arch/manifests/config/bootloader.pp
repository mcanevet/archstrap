class arch::config::bootloader {
  package { 'btrfs-progs':
    ensure => present,
  }
  ~>
  exec { 'mkinitcpio':
    command     => 'mkinitcpio -p linux',
    path        => $::path,
    refreshonly => true,
  }
  ~>
  exec { 'grub-install':
    command     => 'grub-install --target=i386-pc --recheck /dev/sda',
    path        => $::path,
    refreshonly => true,
  }
  ~>
  exec { 'grub-mkconfig':
    command     => 'grub-mkconfig -o /boot/grub/grub.cfg',
    path        => $::path,
    refreshonly => true,
  }
}
