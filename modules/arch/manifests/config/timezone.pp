class arch::config::timezone {
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Europe/Paris',
  }
}
