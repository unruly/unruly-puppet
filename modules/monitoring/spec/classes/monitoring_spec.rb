require 'spec_helper'

describe 'monitoring' do
  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it { is_expected.to contain_class('monitoring::nagios') }
  it { is_expected.to contain_class('monitoring::nagios::plugins') }
  it { is_expected.to contain_class('monitoring::nagios::nsca') }
  it { is_expected.to contain_class('monitoring::nagios::xinetd') }
end
