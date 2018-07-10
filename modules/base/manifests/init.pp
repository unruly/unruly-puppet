# == Class: base
#
# Packages all base::* subclasses.
#
class base {
  include base::ntp

  include base::ssh::server

  include base::yum
  include base::yum::repos::unruly
  include base::yum::repos::epel
  include base::collectd
}
