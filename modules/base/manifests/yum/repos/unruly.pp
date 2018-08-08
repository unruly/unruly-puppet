# == Class: base::yum::repos::unruly
#
# Sets up unruly repository config for yum
#
# === Parameters:
#
# [*baseurl*]
#   Location of the unruly yum repo
#
# [*ensure*]
#   Set ensure property for the yumrepo resource
#
class base::yum::repos::unruly(
  String $baseurl = hiera('base::yum::repos::unruly::baseurl'),
  Enum[present, absent] $ensure = 'present'
) {
  yumrepo { 'unruly' :
    ensure          => $ensure,
    name            => 'unruly',
    descr           => 'new Unruly-wide repo',
    baseurl         => $baseurl,
    gpgcheck        => 0,
    priority        => 'absent',
    metadata_expire => '5m',
  }
}
