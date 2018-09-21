# == Class: base::python
#
# Installs python and pip.
#
class base::python (
  $python_version = hiera('base::python::python_version'),
  $python2_pip_version = hiera('base::python::python2_pip_version')
) {
  package {'python':
    ensure => $python_version,
  }
  package { 'python2-pip':
    ensure  => $python2_pip_version,
    require => Package['python'],
  }
  file { '/usr/bin/pip-python':
    ensure  => 'link',
    target  => '/usr/bin/pip',
    require => Package['python2-pip'],
  }
}
