# == Class: base::collectd
#
# Sets up and configures collectd
#
class base::collectd(
  $version = hiera('base::collectd::version'),
) {
  package { 'collectd':
    ensure => $version,
  }

  service { 'collectd':
    ensure  => 'running',
    enable  => true,
    require => Package['collectd'],
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
  }
}
