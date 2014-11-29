class arch::config::network {
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
