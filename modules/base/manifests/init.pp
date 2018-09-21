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
  include base::yum::repos::epel
  include base::yum::repos::artifactory

  include base::collectd

  include base::syslog_ng

  include base::nrpe

  include base::selinux

  include base::python
}
