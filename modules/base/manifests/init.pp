# == Class: base
#
# Packages all base::* subclasses.
#
class base {
  include base::ntp
  include base::ssh::server
  include base::yum
}
