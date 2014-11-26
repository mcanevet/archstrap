class arch::config {
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Europe/Paris',
  }

  file_line { 'fr_FR.UTF-8 UTF-8':
    line   => 'fr_FR.UTF-8 UTF-8',
    match  => 'fr_FR.UTF-8 UTF-8',
    notify => Exec['locale-gen'],
    path   => '/etc/locale.gen',
  }

  exec { 'locale-gen':
    path        => $::path,
    refreshonly => true,
  }

  file { '/etc/locale.conf':
    ensure  => file,
    content => "LANG=fr_FR.UTF-8\n",
  }

  file { '/etc/vconsole.conf':
    ensure  => file,
    content => "KEYMAP=fr\n",
  }

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

  file { '/etc/systemd/network/MyDhcp.network':
    ensure  => file,
    content => "[Match]\nName=en*\n\n[Network]\nDHCP=v4\n",
    notify  => Service['systemd-networkd'],
  }
  service { 'systemd-networkd':
    ensure => running,
    enable => true,
  }

  service { 'systemd-resolved':
    ensure => running,
    enable => true,
  }
  ->
  file { '/etc/resolv.conf':
    ensure => link,
    target => '/run/systemd/resolve/resolv.conf',
  }

}
