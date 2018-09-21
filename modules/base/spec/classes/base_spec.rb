require 'spec_helper'

describe 'base' do

  it { is_expected.to compile }

  it { is_expected.to contain_class('base::ntp') }
  it { is_expected.to contain_class('base::ssh::server') }
  it { is_expected.to contain_class('base::yum') }
  it { is_expected.to contain_class('base::yum::repos::unruly') }
  it { is_expected.to contain_class('base::yum::repos::epel') }
  it { is_expected.to contain_class('base::yum::repos::artifactory') }
  it { is_expected.to contain_class('base::collectd') }
  it { is_expected.to contain_class('base::syslog_ng') }
  it { is_expected.to contain_class('base::nrpe') }
  it { is_expected.to contain_class('base::selinux') }
  it { is_expected.to contain_class('base::python') }
end
