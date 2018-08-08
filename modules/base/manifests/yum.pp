# == Class: base::yum
#
# Installs base yum plugins on CentOS 7 images.
#
# === Parameters:
#
# [*yum_pkgs*]
#  Array of packages to be installed, defaults to packages listed in hiera
#
class base::yum(
  Array[String] $yum_pkgs = hiera('base::yum::plugins')
) {

  package { $yum_pkgs: ensure => 'installed' }

  include base::yum::clean
}
