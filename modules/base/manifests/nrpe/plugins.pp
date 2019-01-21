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
      File['/etc/nrpe.d', '/etc/sudoers.d/unruly_nrpe_check_disk'],
      Package[
        'nagios-plugins-disk',
        'nagios-plugins-load',
        'nagios-plugins-procs',
        'nagios-plugins-ntp'
      ],
    ],
    notify  => Service['nrpe']
  }

  $nrpe_user = 'nrpe'

  file { '/etc/sudoers.d/unruly_nrpe_check_disk':
    ensure  => present,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    content => "Defaults:${nrpe_user} !requiretty\n${nrpe_user} ALL = NOPASSWD: /usr/lib64/nagios/plugins/check_disk\n"
  }

  file { '/etc/nrpe.d/unruly':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

}
