# == Class: base::wget
#
# Installs wget.
#

class base::wget {
  package { 'wget':
    ensure => 'present',
  }
}
