class arch::config::locales {
  file_line { 'fr_FR.UTF-8 UTF-8':
    line  => 'fr_FR.UTF-8 UTF-8',
    match => 'fr_FR.UTF-8 UTF-8',
    path  => '/etc/locale.gen',
  }
  ~>
  exec { 'locale-gen':
    path        => $::path,
    refreshonly => true,
  }
  ->
  file { '/etc/locale.conf':
    ensure  => file,
    content => "LANG=fr_FR.UTF-8\n",
  }
}
