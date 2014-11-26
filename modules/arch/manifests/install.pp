class arch::install {
  package { ['augeas', 'btrfs-progs', 'vim',]:
    ensure => present,
  }
}
