# == Define: nrpe_custom_check::plugin_config
#
# Sets up nrpe configuration for a plugin.
#
# === Parameters:
#
# [*path_to_plugin*]
#   The absolute path to the nrpe plugin script.
#
# [*ensure*]
#   Whether the plugin configuration should exist or not. Can be 'present' or 'absent'.
#
# [*nrpe_cfg_dir*]
#   The absolute path to the directory containing the nrpe configuration files.
#
# [*plugin_args*]
#   String, space-separated arguments to be passed to the plugin script.
#
# [*requires_sudo*]
#   Boolean, true if the plugin requires root permissions.
#
define nrpe_custom_check::plugin_config(
  $path_to_plugin,
  $ensure = 'present',
  $nrpe_cfg_dir = hiera('nrpe_custom_check::plugin_config::nrpe_cfg_dir'),
  $plugin_args = '',
  $requires_sudo = false,
) {

  file { "${nrpe_cfg_dir}/unruly":
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

  $command = $requires_sudo ? {
    true  => "/usr/bin/sudo ${path_to_plugin} ${plugin_args}",
    false => "${path_to_plugin} ${plugin_args}",
  }

  file { "${nrpe_cfg_dir}/unruly/${name}.cfg":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => [Service['nrpe']],
    content => "command[${name}]=${command}\n",
  }

  $sudo_config_ensure = ($ensure == 'present' and $requires_sudo == true) ? {
    true  => 'present',
    false => 'absent',
  }

  nrpe_custom_check::sudo_config { $name:
    ensure         => $sudo_config_ensure,
    path_to_plugin => $path_to_plugin,
  }
}
