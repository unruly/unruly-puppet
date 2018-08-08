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
  String $version             = hiera('base::collectd::version'),
  String $backend_host        = hiera('base::collectd::backend::host'),
  Integer $backend_port       = hiera('base::collectd::backend::port'),
  Type[Resource] $repository  = Class['base::yum::repos::epel']
) {

  package { 'collectd':
    ensure  => $version,
    require => $repository,
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

  file { '/var/run/collectd-unixsock':
    ensure => 'link',
    target => 'collectd.sock'
  }

  base::collectd::config {'base.conf'    : content => file('base/collectd/base.conf')}
  base::collectd::config {'graphite.conf': content => template('base/collectd/graphite.conf.tpl')}
  base::collectd::config {'unixsock.conf': content => file('base/collectd/unixsock.conf')}

}
