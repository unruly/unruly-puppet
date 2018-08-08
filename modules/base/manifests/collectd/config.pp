# == Define: collectd::config
#
#   Defines collectd configuration resource and notifies the collectd service.
#
# === Parameters:
#
# [*content*]
#   Specifies required configuration content. This must be passed to the define resource.
#
# [*filename*]
#   Specifies configuration file name and defaults to $title.
#
define base::collectd::config(
  String $content,
  String $filename = $title
) {

  file { "/etc/collectd.d/${filename}":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/collectd.d'],
    notify  => Service['collectd'],
    content => $content
  }

}
