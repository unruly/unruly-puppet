# == Class: base::collectd::plugins
#
# Installs base collectd plugins on CentOS 7 images.
#
# === Parameters:
#
# [*collectd_pkgs*]
#  Array of packages to be installed, defaults to packages listed in hiera
#
class base::collectd::plugins (
  $collectd_pkgs = hiera('base::collectd::packages'),
  $version       = hiera('base::collectd::version')
) {
  package { $collectd_pkgs:
    ensure => $version,
  }
}
