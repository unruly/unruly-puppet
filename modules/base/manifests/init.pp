# == Class: base
#
# Packages all base::* subclasses.
#
# == Dependencies:
#
# Installing collectd requires a yum repository with an appropriate version of collectd available.
#  - In this case, we enforce yum::repos::epel to be installed before collectd.
#
class base {
  include base::ntp

  include base::ssh::server

  include base::yum
  include base::yum::repos::unruly
  class { 'base::yum::repos::epel': }
  ->
  class { 'base::collectd': }
}
