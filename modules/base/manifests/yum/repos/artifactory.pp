# base::yum::repos::artifactory
#
# Sets up artifactory repository configuration for yum
#
# === Parameters:
#
# [*baseurl*]
#   Location of the artifactory yum repo
#
# [*ensure*]
#   Set ensure property for the yumrepo resource
#
class base::yum::repos::artifactory(
  String $baseurl = hiera('base::yum::repos::artifactory::baseurl'),
  Enum[absent, present] $ensure  = 'present'
) {
  yumrepo { 'UnrulyArtifactory' :
    ensure   => $ensure,
    descr    => 'Unruly specific packages hosted on Artifactory',
    baseurl  => $baseurl,
    gpgcheck => 0,
  }
}
