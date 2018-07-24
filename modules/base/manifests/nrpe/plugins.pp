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
  $version = hiera('base::nrpe::plugins::version')
) {

  package {
    'nagios-plugins-load':  ensure => $version;
    'nagios-plugins-disk':  ensure => $version;
    'nagios-plugins-procs': ensure => $version;
  }

  file { '/etc/nrpe.d/base-plugins.cfg':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [
      File['/etc/nrpe.d'],
      Package[
        'nagios-plugins-disk',
        'nagios-plugins-load',
        'nagios-plugins-procs'
      ]
    ],
    notify  => Service['nrpe']
  }

}
