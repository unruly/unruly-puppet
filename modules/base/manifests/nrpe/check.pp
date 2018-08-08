# == Define: base::nrpe::check
#
#   Defines nrpe check configuration and plugin directory structure.
#
# === Parameters:
#
# [*content*]
#   Specifies required plugin script content. This must be passed to the define resource.
#
# [*script*]
#   Specifies script file name and defaults to $title.
#
define base::nrpe::check(
  String $content,
  String $script = $title
) {

  file { "/usr/lib64/nagios/plugins/${script}":
    ensure  => 'present',
    mode    => '0755',
    content => $content,
  }

  file { "/etc/nrpe.d/${title}.cfg":
    ensure  => 'present',
    mode    => '0644',
    content => "command[${title}]=/usr/lib64/nagios/plugins/${script}",
    notify  => Service['nrpe']
  }
}
