# == Class: base::nrpe
#
# Sets up and configures nrpe
#
# === Parameters:
#
# [*version*]
#  Desired version of nrpe
#
# [*allowed_hosts*]
#  List of hostnames permitted to run NRPE queries
#
class base::nrpe(
  $version  = hiera('base::nrpe::version'),
  $allowed_hosts = hiera('base::nrpe::allowed_hosts')
) {

  package { 'nrpe':
    ensure => $version
  }

  service { 'nrpe':
    ensure    => 'running',
    enable    => true,
    require   => Package['nrpe'],
    subscribe => File['/etc/nagios/nrpe.cfg']
  }

  file { '/etc/nagios/nrpe.cfg':
    ensure  => 'present',
    group   => 'root',
    owner   => 'root',
    mode    => '0644',
    content => template('base/nrpe/nrpe.cfg.tpl'),
    require => Package['nrpe'],
  }

}
