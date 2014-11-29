class arch::config::keymap {
  file { '/etc/vconsole.conf':
    ensure  => file,
    content => "KEYMAP=fr\n",
  }
}
