# == Class: base::collectd
#
# Sets up and configures collectd
#
class base::collectd(
  $version        = hiera('base::collectd::version'),
  $graphite_host  = hiera('base::collectd::graphite::host'),
  $graphite_port  = hiera('base::collectd::graphite::port'),
) {
  package { 'collectd':
    ensure => $version,
  }

  service { 'collectd':
    ensure  => 'running',
    enable  => true,
    require => Package['collectd'],
  }

  file { '/etc/collectd.d/':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    before => File['/etc/collectd.d/base.conf'],
  }

  file { '/etc/collectd.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('base/collectd/collectd.conf'),
  }

  file { '/etc/collectd.d/base.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('base/collectd/base.conf'),
    require => File['/etc/collectd.d'],
  }

  file { '/etc/collectd.d/graphite.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('base/collectd/graphite.conf.tpl'),
    require => File['/etc/collectd.d'],
  }

  file { '/etc/collectd.d/unixsock.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('base/collectd/unixsock.conf'),
    require => File['/etc/collectd.d'],
  }

  file { '/var/run/collectd-unixsock':
    ensure => 'link',
    target => 'collectd.sock'
  }
}
