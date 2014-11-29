class arch::config::network(
  $provider = 'networkmanager',
) {
  case $provider {
    'systemd': {
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
    'networkmanager': {
      package { 'networkmanager':
        ensure => 'present',
        before => Service['NetworkManager'],
      }
      ~>
      service { 'NetworkManager':
        ensure => 'running',
        enable => true,
      }
    }
  }
}
