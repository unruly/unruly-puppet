# unruly-puppet

[![Build Status](https://travis-ci.org/unruly/unruly-puppet.svg?branch=master)](https://travis-ci.org/unruly/unruly-puppet)

Modules for Unruly's puppet codebase

## Modules

| Module   | Resource           | Description |
|:-------------|:-------------|:-----|
| credentials  | `credentials` | Manages the `/etc/credentials` directory tree for storing configuration files. |
| base         | `base::yum`      | Installs base yum plugins on CentOS 7 images. Uses hiera to source plugins by default, but can be customised.  |
|              | `base::yum::clean`      |   Sets up a cronjob to clean Yum repo metadata once per day at random, determined by FQDN. |
|              | `base::ssh::server`      |   Ensures sshd is running and sets up sshd configuration. | 
|              |`base::ssh::server::config` | Configures the SSH daemon. |
