class arch::config {
  class { 'arch::config::timezone': }
  class { 'arch::config::locales': }
  class { 'arch::config::keymap': }
  class { 'arch::config::network': }
  class { 'arch::config::bootloader': }
  class { 'arch::config::xorg': }
}
