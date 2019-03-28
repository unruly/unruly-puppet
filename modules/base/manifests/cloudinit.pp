# == Class: base::cloudinit
#
# Ensures that cloud-init is disabled.
#
class base::cloudinit {
  file { '/etc/cloud/cloud-init.disabled':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
