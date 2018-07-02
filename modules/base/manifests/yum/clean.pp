# == Class: base::yum::clean
#
# Sets up a cronjob to clean Yum repo metadata once per day at random, determined by FQDN
#
class base::yum::clean {
  cron { 'clean_yum_cache_from_nagios_security_check':
    user    => 'root',
    command => "su - nagios -s /bin/bash  -c '/usr/bin/yum clean all' 2>&1 | logger -i -t yum-clean",
    minute  => fqdn_rand(60, 'clean-yum-cache-minute'),
    hour    => fqdn_rand(24, 'clean-yum-cache-hour')
  }
}
