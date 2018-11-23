# == Class: monitoring::nagios::nsca
#
# Installs nsca for accepting passive checks.
#
# === Parameters:
#
# [*version*]
#  Desired version of nsca
#
class monitoring::nagios::nsca (
  $version = hiera('monitoring::nagios::nsca::version')
) {
  package { 'nsca':
    ensure => $version;
  }
}
