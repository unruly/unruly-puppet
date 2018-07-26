# == Class: base::selinux
#
# Configures selinux in permissive mode for this system
#
class base::selinux {

  file { '/etc/selinux/config':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "SELINUX=permissive\nSELINUXTYPE=targeted\n"
  }

}