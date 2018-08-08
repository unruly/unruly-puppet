# == Class: base::yum::repos::epel
#
# Sets up yum repository config for epel
#
# === Parameters:
#
# [*version*]
#   To specify the version of epel-release
#
class base::yum::repos::epel(
  String $version = hiera('base::yum::repos::epel::version')
) {
  package { 'epel-release':
    ensure => $version,
  }
}
