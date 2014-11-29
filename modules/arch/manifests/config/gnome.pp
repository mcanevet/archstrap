class arch::config::gnome {
  package { ['gnome', 'gnome-extra',]:
    ensure => 'present',
  }
  package { 'gdm':
    ensure => 'present',
  }
  ~>
  exec { 'systemctl enable gdm':
    path        => $::path,
    refreshonly => true,
  }
}
