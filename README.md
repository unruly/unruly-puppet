# unruly-puppet

[![Build Status](https://travis-ci.org/unruly/unruly-puppet.svg?branch=master)](https://travis-ci.org/unruly/unruly-puppet)
![GitHub tag](https://img.shields.io/github/tag/unruly/unruly-puppet.svg)
![GitHub](https://img.shields.io/github/license/unruly/unruly-puppet.svg)


## Contents

 - [Introduction](#introduction)
 - [Building](#building)
 - [Testing](#testing)
 - [Versioning](#versioning)
 - [Usage](#usage)
 - [Modules](#modules)
 
## Introduction

This project contains puppet modules used by Unruly for configuration management, developed in the open to improve code quality and decouple data (e.g. credentials and secrets) from configuration.

## Building

unruly-puppet requires Puppet, Ruby, [pdk](https://puppet.com/docs/pdk/1.x/pdk.html), and [pre-commit](https://pre-commit.com/) installed.

```bash
$ git clone git@github.com:unruly/unruly-puppet.git

$ pre-commit install # install validation pre-commit hooks
```

## Testing

We use [pdk](https://puppet.com/docs/pdk/1.x/pdk.html) to test and build this project.

```bash
$ ./lint-and-test.sh # run puppet parser to validate files, and pdk test on all modules
```

## Versioning

unruly-puppet is versioned with tags against the master branch e.g. `v0.0.10`

We aim to support [Semantic Versioning](https://semver.org/) as closely as possible.

## Usage

Individual modules can be imported in your Puppetfile using `librarian` e.g.

```ruby
  def unruly_mod(name, version)
    mod "unruly/#{name}",
      :git    => 'git@github.com:unruly/unruly-puppet.git',
      :path   => "modules/#{name}",
      :ref    => version
  end
  
  unruly_mod 'base', 'v0.0.10'      
```


## Modules

| Module       | Resource     | Description |
|:-------------|:-------------|:------------|
| credentials  | `credentials`               | Manages the `/etc/credentials` directory tree for storing configuration files. |
| base         | `base`                      | Includes `base::*` subclasses. |
|              | `base::yum`                 | Installs base yum plugins on CentOS 7 images. Uses hiera to source plugins by default, but can be customised.  |
|              | `base::yum::clean`          | Sets up a cronjob to clean Yum repo metadata once per day at random, determined by FQDN. |
|              | `base::yum::repos::unruly`  | Sets up unruly repository configuration for yum. |
|              | `base::yum::repos::epel`    | Sets up unruly repository configuration for EPEL. |  
|              | `base::yum::repos::artifactory`    | Sets up unruly repository configuration for Artifactory. |  
|              | `base::ssh::server`         | Ensures sshd is running and sets up sshd configuration. | 
|              | `base::ssh::server::config` | Configures the SSH daemon. |
|              | `base::ntp`                 | Installs ntp and ensures that the daemon is running. |  
|              | `base::collectd`            | Installs collectd, provides configuration, and ensures service is running. |  
|              | `base::collectd::config`    | Defines configuration resource for backend service (e.g. graphite). |  
|              | `base::syslog_ng`           | Installs syslog-ng for system logging and removes known incompatible logging packages |  
|              | `base::nrpe`                | Installs nrpe, provides base configuration, and ensures service is running |  
|              | `base::nrpe::plugins`       | Sets up and configures default NRPE plugins for every node |  
|              | `base::nrpe::check`         | Defines nrpe check configuration and plugin directory structure. |
|              | `base::selinux`             | Sets up SELinux for the system. |    
