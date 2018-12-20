# == Define: nrpe_custom_check
#
# Sets up an nrpe plugin and its configuration.
#
# === Parameters:
#
# [*plugin_module_path*]
#   Puppet module in which to find the nrpe plugin script.
#
# [*plugin_name*]
#   The file name of the nrpe plugin script.
#
# [*ensure*]
#   Whether resources for a check should exist or not. Can be 'present' or 'absent'.
#
# [*plugin_args*]
#   String, space-separated arguments to be passed to the plugin script.
#
# [*plugins_directory*]
#   The absolute path to the nrpe plugins directory.
#
# [*requires_sudo*]
#   Boolean, true if the plugin requires root permissions.
#
define nrpe_custom_check(
  $plugin_module_path,
  $plugin_name,
  $ensure = 'present',
  $plugin_args = '',
  $plugins_directory = hiera('nrpe_custom_check::plugins_directory'),
  $requires_sudo = false,
) {
  nrpe_custom_check::plugin { $plugin_name:
    ensure             => $ensure,
    plugin_module_path => $plugin_module_path
  }

  nrpe_custom_check::plugin_config { $name:
    ensure         => $ensure,
    plugin_args    => $plugin_args,
    path_to_plugin => "${plugins_directory}/${plugin_name}",
    requires_sudo  => $requires_sudo
  }
}