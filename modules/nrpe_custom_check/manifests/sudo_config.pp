# == Define: nrpe_custom_check::sudo_config
#
# Manages sudoers confiugation for an individual nrpe plugin that requires extra permissions.
#
# === Parameters:
#
# [*path_to_plugin*]
#   The absolute path to the nrpe plugin script.
#
# [*ensure*]
#   Whether the sudoers configuration should exist or not. Can be 'present' or 'absent'.
#
# [*user*]
#   The name of the user that runs nrpe plugins.
#
define nrpe_custom_check::sudo_config(
  $path_to_plugin,
  $ensure = 'present',
  $user = hiera('nrpe_custom_check::sudo_config::user'),
) {

  file { "/etc/sudoers.d/unruly_nrpe_${name}":
    ensure  => $ensure,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    content => "Defaults:${user} !requiretty\n${user} ALL = NOPASSWD: ${path_to_plugin}\n",
  }
}
