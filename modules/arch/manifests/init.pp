class arch(
  $user = 'admin',
) {
  package { ['augeas', 'vim',]:
    ensure => present,
  }

  class { 'arch::config::timezone': }
  class { 'arch::config::locales': }
  class { 'arch::config::keymap': }
  class { 'arch::config::network':
    provider => 'networkmanager',
  }
  class { 'arch::config::bootloader': }
  class { 'arch::config::user': }
  class { 'arch::config::xorg': }
  class { 'arch::config::gnome': }
  class { 'arch::config::aur': }
}
