# == Class: monitoring::nagios::xinetd
#
# Installs, configures and starts xinetd.
#
# [*version*]
#  Desired version of xinetd
#
class monitoring::nagios::xinetd (
  $version = hiera('monitoring::nagios::xinetd::version')
) {
  package { 'xinetd':
    ensure => $version;
  }
}
