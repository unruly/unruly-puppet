# == Class: monitoring::nagios
#
# Installs and starts nagios
#
# === Parameters:
#
# [*version*]
#  Desired version of nagios
#
class monitoring::nagios (
  $version = hiera('monitoring::nagios::version'),
) {
  package { 'nagios':
    ensure  => $version,
    require => Class['base::yum::repos::epel'],
  }
  service { 'nagios':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    restart    => 'nagios -v /etc/nagios/nagios.cfg && systemctl restart nagios',
    require    => Package['nagios'],
  }
}
