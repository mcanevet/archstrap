class arch::config::enlightenment {
  package { ['enlightenment', 'terminology']:
    ensure => present,
  }
}
