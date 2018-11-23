require 'spec_helper'

describe 'monitoring::nagios::xinetd' do
  let(:pre_condition) { 'include monitoring::nagios' }
  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it { is_expected.to contain_package('xinetd').with_ensure('some-xinetd-version') }

end
