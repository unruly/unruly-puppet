# == Class: monitoring
#
# Packages all monitoring::* subclasses.
#
class monitoring {
  include monitoring::nagios
  include monitoring::nagios::plugins
  include monitoring::nagios::nsca
  include monitoring::nagios::xinetd
}