# unruly-puppet

[![Build Status](https://travis-ci.org/unruly/unruly-puppet.svg?branch=master)](https://travis-ci.org/unruly/unruly-puppet)

Modules for Unruly's puppet codebase

## Modules

| Module       | Resource     | Description |
|:-------------|:-------------|:------------|
| credentials  | `credentials`               | Manages the `/etc/credentials` directory tree for storing configuration files. |
| base         | `base`                      | Includes `base::*` subclasses. |
|              | `base::yum`                 | Installs base yum plugins on CentOS 7 images. Uses hiera to source plugins by default, but can be customised.  |
|              | `base::yum::clean`          | Sets up a cronjob to clean Yum repo metadata once per day at random, determined by FQDN. |
|              | `base::yum::repos::unruly`  | Sets up unruly repository configuration for yum. |
|              | `base::yum::repos::epel`    | Sets up unruly repository configuration for EPEL. |  
|              | `base::ssh::server`         | Ensures sshd is running and sets up sshd configuration. | 
|              | `base::ssh::server::config` | Configures the SSH daemon. |
|              | `base::ntp`                 | Installs ntp and ensures that the daemon is running. |  
|              | `base::collectd`            | Installs collectd, provides configuration, and ensures service is running. |  
|              | `base::collectd::config`    | Defines configuration resource for backend service (e.g. graphite). |  
|              | `base::syslog_ng`           | Installs syslog-ng for system logging and removes known incompatible logging packages |  
