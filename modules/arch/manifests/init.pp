class arch {
  class { 'arch::install': } ->
  class { 'arch::config': } ->
  Class['arch']

  class { 'arch::xorg': }
}

