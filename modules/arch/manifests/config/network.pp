class arch::config::network(
  $provider,
) {
  case $provider {
    'connman': {
      package { 'connman':
        ensure => present,
      }
      ->
      service { 'connman':
        ensure => running,
        enable => true,
      }
    }
    'dhcpcd': {
      service { 'connman':
        ensure => stopped,
        enable => false,
      }
      service { 'dhcpcd':
        ensure => running,
        enable => true,
      }
      service { 'NetworkManager':
        ensure => stopped,
        enable => false,
      }
      service { ['systemd-networkd', 'systemd-resolved']:
        ensure => stopped,
        enable => false,
      }
    }
    'networkmanager': {
      service { 'connman':
        ensure => stopped,
        enable => false,
      }
      service { 'dhcpcd':
        ensure => stopped,
        enable => false,
      }

      package { 'networkmanager':
        ensure => present,
        before => Service['NetworkManager'],
      }
      ~>
      service { 'NetworkManager':
        ensure => running,
        enable => true,
      }

      service { ['systemd-networkd', 'systemd-resolved']:
        ensure => stopped,
        enable => false,
      }
    }
    'systemd-networkd': {
      service { 'connman':
        ensure => stopped,
        enable => false,
      }
      service { 'dhcpcd':
        ensure => stopped,
        enable => false,
      }
      service { 'NetworkManager':
        ensure => stopped,
        enable => false,
      }

      file { '/etc/systemd/network/MyDhcp.network':
        ensure  => file,
        content => "[Match]\nName=en*\n\n[Network]\nDHCP=v4\n",
      }
      ~>
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
  }
}
