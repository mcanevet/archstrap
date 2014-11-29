class arch::config::virtualbox {
  package { [ 'virtualbox-guest-iso', 'virtualbox-guest-utils', ]:
    ensure => 'present',
  }
}
