# == Class: base::yum::repos::unruly
#
# Sets up unruly repository config for yum
#
class base::yum::repos::unruly(
  $baseurl = hiera('base::yum::repos::unruly::baseurl'),
  $ensure = 'present'
) {
  yumrepo { 'unruly' :
    ensure          => $ensure,
    name            => 'unruly',
    descr           => 'new Unruly-wide repo',
    baseurl         => $baseurl,
    gpgcheck        => 0,
    priority        => 20,
    metadata_expire => '5m',
  }
}
