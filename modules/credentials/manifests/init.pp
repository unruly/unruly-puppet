define credentials(
  $system,
  $config
) {

  if !defined(File['/etc/credentials']) {
    file { '/etc/credentials' :
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }

  if !defined(File["/etc/credentials/${system}"]) {
    file { "/etc/credentials/${system}":
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File["/etc/credentials"],
    }
  }

  file { "/etc/credentials/${system}/${title}" :
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["/etc/credentials/${system}"],
  }

  file { "/etc/credentials/${system}/${title}/credentials.sh" :
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("credentials/credentials.sh.tpl"),
    require => File["/etc/credentials/${system}/${title}"]
  }

  file { "/etc/credentials/${system}/${title}/credentials.properties" :
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("credentials/credentials.properties.tpl"),
    require => File["/etc/credentials/${system}/${title}"]
  }

  file { "/etc/credentials/${system}/${title}/credentials.json" :
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("credentials/credentials.json.tpl"),
    require => File["/etc/credentials/${system}/${title}"]
  }

}