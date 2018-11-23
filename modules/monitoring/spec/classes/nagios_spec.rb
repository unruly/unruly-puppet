require 'spec_helper'

describe 'monitoring::nagios' do

  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it {
    is_expected.to contain_package('nagios').with(
      :ensure => 'some-version',
      ).that_requires('Class[base::yum::repos::epel]')
  }

  it {
    is_expected.to contain_service('nagios').with(
      :ensure     => 'running',
      :enable     => 'true',
      :hasrestart => 'true',
      :restart    => 'nagios -v /etc/nagios/nagios.cfg && systemctl restart nagios'
    ).that_requires('Package[nagios]')
  }
end
