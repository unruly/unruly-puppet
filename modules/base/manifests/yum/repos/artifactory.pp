# base::yum::repos::artifactory
#
# Sets up artifactory repository configuration for yum
#
# === Parameters:
#
# [*credentials*]
#   Address for credentials in encrypted datastore
#
# [*baseurl*]
#   Location of the artifactory yum repo
#
# [*ensure*]
#   Set ensure property for the yumrepo resource
#
class base::yum::repos::artifactory(
  String $credentials = hiera('base::yum::repos::artifactory::credentials'),
  String $baseurl     = hiera('base::yum::repos::artifactory::baseurl'),
  Enum[absent, present] $ensure  = 'present'
) {
  # Lookup credentials from encrypted store
  $artifactory_credentials = hiera_hash($credentials)

  yumrepo { 'UnrulyArtifactory' :
    ensure   => $ensure,
    descr    => 'Unruly specific packages hosted on Artifactory',
    baseurl  => "https://${artifactory_credentials['user']}:${artifactory_credentials['pass']}@${baseurl}",
    gpgcheck => 0,
  }
}
