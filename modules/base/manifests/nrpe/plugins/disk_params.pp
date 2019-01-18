# == Class: base::nrpe::plugins::disk_params
#
# Contains the nrpe parameters for disk fill related checks
#
# === Parameters:
#
# [*command*]
#  Name of the command called by Nagios
#
# [*important*]
# Dictates the immediacy of the alert, should the check fail
#
# [*thr_critical*]
# Threshold to exceed for the check to return a critical state
#
# [*thr_warning*]
# Threshold to exceed for the check to return a warning state
#
class base::nrpe::plugins::disk_params(
  String $command      = hiera('base::nrpe::disk_params::command'),
  Boolean $important   = hiera('base::nrpe::disk_params::important'),
  String $thr_critical = hiera('base::nrpe::disk_params::thr_critical'),
  String $thr_warning  = hiera('base::nrpe::disk_params::thr_warning'),
) {
}