class arch::config::gnome {
  package { ['gnome', 'gnome-extra',]:
    ensure => 'present',
  }
  package { 'gdm':
    ensure => 'present',
  }
  ~>
  service { 'gdm':
    ensure => 'running',
    enable => true,
  }
}
