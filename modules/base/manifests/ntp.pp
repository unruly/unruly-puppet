# == Class: base::ntp
#
# Installs ntp and ensures that the daemon is running.
#
class base::ntp {
  package { 'ntp':
    ensure   => 'installed',
  }

  service { 'ntpd':
    ensure   => 'running',
    enable   => 'true',
  }
}
