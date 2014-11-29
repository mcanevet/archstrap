class arch::config::user {
  user { $::arch::user:
    ensure => 'present',
    groups => 'wheel',
  }
}
