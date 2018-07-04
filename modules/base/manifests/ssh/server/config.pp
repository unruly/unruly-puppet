# == Class: base::ssh::server::config
#
# Configures the SSH daemon.
#
class base::ssh::server::config {
  file { '/etc/ssh/sshd_config' :
    content => file('base/ssh/sshd_config'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }
}
