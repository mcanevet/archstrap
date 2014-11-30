class arch::config::aur {
  package { 'base-devel':
    ensure => present,
  }

  Ini_setting {
    ensure  => present,
    path    => '/etc/pacman.conf',
    section => 'archlinuxfr',
    before  => Package['yaourt']
  }
  ini_setting { 'SigLevel':
    setting => 'SigLevel',
    value   => 'Never',
  }
  ini_setting { 'Server':
    setting => 'Server',
    value   => "http://repo.archlinux.fr/\$arch",
  }

  package { 'yaourt':
    ensure => present,
  }
}
