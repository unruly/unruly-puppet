# == Class: base::collectd
#
# Sets up and configures collectd
#
# === Parameters:
#
# [*version*]
#  Desired version of collectd
#
# [*backend_host*]
#  Designated hostname for a backend i.e. graphite
#
# [*backend_port*]
#  Designated port for a backend i.e. graphite
class base::collectd(
  $version        = hiera('base::collectd::version'),
  $backend_host  = hiera('base::collectd::backend::host'),
  $backend_port  = hiera('base::collectd::backend::port'),
) {
  package { 'collectd':
    ensure => $version,
  }

  service { 'collectd':
    ensure    => 'running',
    enable    => true,
    require   => Package['collectd'],
    subscribe => File['/etc/collectd.conf'],
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
    notify  => Service['collectd'],
  }

  file { '/etc/collectd.d/graphite.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('base/collectd/graphite.conf.tpl'),
    require => File['/etc/collectd.d'],
    notify  => Service['collectd'],
  }

  file { '/etc/collectd.d/unixsock.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('base/collectd/unixsock.conf'),
    require => File['/etc/collectd.d'],
    notify  => Service['collectd'],
  }

  file { '/var/run/collectd-unixsock':
    ensure => 'link',
    target => 'collectd.sock'
  }
}
