# == Class: base::ssh::server
#
# Ensure SSHd service is running
#
class base::ssh::server {

  include base::ssh::server::config

  service { 'sshd':
    ensure    => 'running',
    subscribe => File['/etc/ssh/sshd_config'],
  }

}