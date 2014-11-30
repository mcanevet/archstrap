class arch::config::aur {
  package { 'base-devel':
    ensure => present,
  }
  file { '/etc/pacman.d/archlinuxfr':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch",
  }
  ->
  package { 'yaourt':
    ensure => present,
  }
}
