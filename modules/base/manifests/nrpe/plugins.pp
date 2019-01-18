# == Class: base::nrpe::plugins
#
# Sets up and configures default NRPE plugins for every node
#
# === Parameters:
#
# [*version*]
#  Desired version of NRPE default plugins
#
class base::nrpe::plugins(
  String $version = hiera('base::nrpe::plugins::version')
) {

  include base::nrpe::plugins::disk_params
  include base::nrpe::plugins::load_params

  package {
    'nagios-plugins-load':  ensure => $version;
    'nagios-plugins-disk':  ensure => $version;
    'nagios-plugins-procs': ensure => $version;
    'nagios-plugins-ntp':   ensure => $version;
  }

  file { '/etc/nrpe.d/base-plugins.cfg':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('base/nrpe/base-plugins.cfg'),
    require => [
      File['/etc/nrpe.d'],
      Package[
        'nagios-plugins-disk',
        'nagios-plugins-load',
        'nagios-plugins-procs',
        'nagios-plugins-ntp'
      ]
    ],
    notify  => Service['nrpe']
  }

  file { '/etc/nrpe.d/unruly':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

}
