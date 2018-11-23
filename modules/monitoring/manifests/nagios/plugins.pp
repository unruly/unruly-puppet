# == Class: monitoring::nagios::plugins
#
# Installs a default set of nagios plugins.
#
# === Parameters:
#
# [*version*]
#  Desired version of nagios plugins, this can mostly be shared across plugins
#
# [*nrpe_version*]
#  Desired version of nrpe plugin
#
class monitoring::nagios::plugins(
  $version = hiera('monitoring::nagios::plugins::version'),
  $nrpe_version = hiera('monitoring::nagios::plugins::nrpe_version'),
) {
  package {
    'nagios-plugins-nagios': ensure => $version;
    'nagios-plugins-http': ensure => $version;
    'nagios-plugins-ping': ensure => $version;
    'nagios-plugins-ssh': ensure => $version;
    'nagios-plugins-dummy': ensure => $version;
    'nagios-plugins-nrpe': ensure => $nrpe_version;
  }
}
