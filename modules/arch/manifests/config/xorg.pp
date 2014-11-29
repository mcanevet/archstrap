class arch::config::xorg {
  package { ['xorg-server', 'xorg-xinit', 'xorg-server-utils', ]:
    ensure => 'present',
  }
  ->
  exec { 'localectl set-x11-keymap fr':
    creates => '/etc/X11/xorg.conf.d/00-keyboard.conf',
    path    => $::path,
  }

  # Simple TWM env
  package { ['xorg-twm', 'xorg-xclock', 'xterm',]:
    ensure => 'present',
  }

  # Nice fonts
  package { [
    'xorg-fonts-type1', 'ttf-dejavu', 'artwiz-fonts', 'font-bh-ttf',
    'font-bitstream-speedo', 'gsfonts', 'sdl_ttf', 'ttf-bitstream-vera',
    'ttf-cheapskate', 'ttf-liberation',]:
    ensure => 'present',
  }
}
