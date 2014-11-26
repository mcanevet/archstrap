class arch::config::xorg {
  exec { 'localectl set-x11-keymap fr':
    creates => '/etc/X11/xorg.conf.d/00-keyboard.conf',
    path    => $::path,
  }
}
