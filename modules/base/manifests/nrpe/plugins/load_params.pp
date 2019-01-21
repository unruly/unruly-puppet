# == Class: base::nrpe::plugins::load_params
#
# Contains the nrpe parameters for load related checks
#
# === Parameters:
#
# [*attempts*]
#  Number of times Nagios should retry the check upon failure
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
# [*hostgroup*]
# Hostgroup used by Nagios to assign checks to teams
#
class base::nrpe::plugins::load_params(
  Integer $attempts    = hiera('base::nrpe::load_params::attempts'),
  String $command      = hiera('base::nrpe::load_params::command'),
  Boolean $important   = hiera('base::nrpe::load_params::important'),
  String $thr_critical = hiera('base::nrpe::load_params::thr_critical'),
  String $thr_warning  = hiera('base::nrpe::load_params::thr_warning'),
  String $hostgroup    = hiera('base::nrpe::hostgroup')
) {
}