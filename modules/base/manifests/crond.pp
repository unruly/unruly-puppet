# == Class: base::crond
#
# Ensures the crond service is running.
#
class base::crond {
  service { 'crond':
    ensure => running,
    enable => true,
  }
}
