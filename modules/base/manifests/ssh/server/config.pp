# base::ssh::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include base::ssh::server::config
class base::ssh::server::config {
  file { '/etc/ssh/sshd_config' :
    content => file('base/ssh/sshd_config'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }
}
