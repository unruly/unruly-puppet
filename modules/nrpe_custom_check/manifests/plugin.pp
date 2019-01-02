# == Define: nrpe_custom_check::plugin
#
# Sets up an individual nrpe plugin script.
#
# === Parameters:
#
# [*content*]
#   Contents of the plugin script file.
#
# [*ensure*]
#   Whether the plugin file should exist or not. Can be 'present' or 'absent'.
#
# [*nrpe_class*]
#   The name of the puppet class which sets up and installs nrpe.
#
# [*nrpe_plugins_dir*]
#   The absolute path to the directory containing the nrpe plugins.
#
define nrpe_custom_check::plugin(
  $content,
  $ensure = 'present',
  $nrpe_class = hiera('nrpe_custom_check::plugin::nrpe_class'),
  $nrpe_plugins_dir = hiera('nrpe_custom_check::plugins_directory'),
) {
  file { "${nrpe_plugins_dir}/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => [Class[$nrpe_class]],
    content => $content,
  }
}