# == Class: base::awscli
#
# Install awscli from pip, and symlink it so it is available on all paths
#
class base::awscli {

  file {'/usr/local/bin/aws':
    ensure  => link,
    target  => '/bin/aws',
    require => Package['awscli']
  }

  package { 'awscli':
    ensure   => 'present',
    provider => 'pip',
  }
}
