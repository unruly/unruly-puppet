require 'spec_helper'

describe 'monitoring::nagios::plugins' do
  let(:pre_condition) { 'include monitoring::nagios' }
  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it { is_expected.to contain_package('nagios-plugins-nagios').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-http').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-ping').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-ssh').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-dummy').with_ensure('some-plugins-version') }

  it { is_expected.to contain_package('nagios-plugins-nrpe').with_ensure('some-nrpe-version') }
end
